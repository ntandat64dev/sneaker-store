using App.Models;
using Data.Service;
using System.Web.Mvc;

namespace App.Controllers
{
    public class ProductsController : Controller
    {
        public ActionResult ListProducts(int id, int? page)
        {
            return View(ProductsModel.CreateModel(id: id, pageSize: 6, page: page));
        }

        public ActionResult ProductDetails(int id)
        {
            ViewBag.Product = ProductService.FindProductById(id);
            ViewBag.Newest = ProductService.FindNewestProducts();

            return View();
        }
    }
}