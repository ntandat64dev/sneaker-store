using Data.Entity;
using Data.Service;
using System.Collections.Generic;
using System.Net;
using System.Web.Mvc;

namespace App.Controllers
{
    public class CartController : Controller
    {
        private const string CartSession = "CartSession";

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AddItems(int idProduct, int quantity)
        {
            // Lấy ra List<CartItem> trong Session, nếu chưa có thì tạo một cái.
            var cartItems = Session[CartSession] as List<CartItem> ?? new List<CartItem>();
            // Tìm kiếm CartItem trong danh sách `cartItems`.
            var item = cartItems.Find(e => e.Product.Id_product == idProduct);
            if (item != null)
            {
                // Nếu đã có item trong danh sách thì tăng số lượng sản phẩm trong item đó.
                item.Quantity += quantity;
            }
            else
            {
                // Nếu chưa có item trong danh sách thì tạo một CartItem mới và thêm vào danh sách.
                var cartItem = new CartItem
                {
                    Product = ProductService.FindProductById(idProduct),
                    Quantity = quantity
                };
                cartItems.Add(cartItem);
            }

            // Thêm List<CartItem> vào Session.
            Session[CartSession] = cartItems;

            return new HttpStatusCodeResult(HttpStatusCode.OK);
        }

        public ActionResult MinusQuantity(int idProduct)
        {
            if (Session[CartSession] is List<CartItem> cartItems)
            {
                var item = cartItems.Find(e => e.Product.Id_product == idProduct);
                if (item != null)
                {
                    if (item.Quantity == 1)
                        cartItems.Remove(item);
                    else
                        item.Quantity--;
                }
            }

            return new HttpStatusCodeResult(HttpStatusCode.OK);
        }

        public ActionResult RemoveItem(int idProduct)
        {
            if (Session[CartSession] is List<CartItem> cartItems)
            {
                var item = cartItems.Find(e => e.Product.Id_product == idProduct);
                if (item != null)
                {
                    cartItems.Remove(item);
                }
            }

            return new HttpStatusCodeResult(HttpStatusCode.OK);
        }
    }
}