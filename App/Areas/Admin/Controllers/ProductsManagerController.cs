using App.Areas.Admin.Models;
using Data.Entity;
using Data.Service;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Web;
using System.Web.Mvc;

namespace App.Areas.Admin.Controllers
{
    public class ProductsManagerController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Products = ProductService.FindAllProducts();
            return View();
        }

        [HttpGet]
        public ActionResult AddProduct()
        {
            PopulateViewBag();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddProduct(AddProductModel model, List<HttpPostedFileBase> images)
        {
            if (!ModelState.IsValid || images == null)
            {
                PopulateViewBag();
                return View(model);
            }

            var imagePath = string.Empty;    // The last image path.
            foreach (var image in images)
            {
                if (image != null && image.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(image.FileName);
                    var absolutePath = Path.Combine(Server.MapPath("~/Content/Images/UploadedProducts"), fileName);
                    image.SaveAs(absolutePath);
                    imagePath = string.Format("/Content/Images/UploadedProducts/{0}", fileName);
                }
            }

            var product = new Product()
            {
                Name_product = model.NameProduct,
                Desc_product = model.Description,
                Url_img_product = imagePath,
                Quantity_product = model.Quantity,
                Id_type = model.TypeId,
                Id_status = model.StatusId,
                Id_supplier = model.SupplierId,
                Listed_price = model.ListedPrice,
                Current_price = model.CurrentPrice,
                Star = 4,
            };
            var admin = Session["ADMIN_SESSION"] as Data.Entity.Admin;

            var isSuccess = ProductService.InsertProduct(product, admin);
            if (!isSuccess)
            {
                TempData["IsAddProductSuccess"] = false;
                PopulateViewBag();
                return View(model);
            }

            TempData["IsAddProductSuccess"] = true;
            return RedirectToAction("AddProduct");
        }

        [HttpPost]
        public ActionResult DeleteProduct(int id)
        {
            if (!ProductService.DeleteProductById(id))
            {
                return new HttpStatusCodeResult(500);
            }
            return new HttpStatusCodeResult(200);
        }

        [HttpPost]
        public ActionResult UpdateProduct(int id, [Bind(Include = "Id_product,Name_product,Quantity_product,Listed_price,Current_price,Id_status,Id_type")] Product product)
        {
            if (!ProductService.UpdateProduct(id, product))
            {
                return new HttpStatusCodeResult(500);
            }
            return new HttpStatusCodeResult(200);
        }

        private void PopulateViewBag()
        {
            var typeProducts = ProductService.FindAllTypeProducts();
            typeProducts.Insert(0, new TypeProduct(-1, "-- Chọn loại sản phẩm --"));
            ViewBag.TypeProducts = typeProducts;

            var statusProducts = ProductService.FindAllStatusProducts();
            statusProducts.Insert(0, new StatusProduct(-1, "-- Chọn trạng thái sản phẩm --"));
            ViewBag.StatusProducts = statusProducts;

            var suppliers = ProductService.FindAllSuppliers();
            suppliers.Insert(0, new Supplier(-1, "-- Chọn nhà cung cấp --"));
            ViewBag.Suppliers = suppliers;
        }
    }
}