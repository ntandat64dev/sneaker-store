using Data.Entity;
using Data.Service;
using System.Collections.Generic;
using System.Net;
using System.Web.Mvc;

namespace App.Controllers
{
    public class CheckoutController : Controller
    {
        public ActionResult Index()
        {
            if (Session["auth_customer"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            if (Session["CartSession"] == null || (Session["CartSession"] as List<CartItem>).Count == 0)
            {
                return Content("<script language='javascript' type='text/javascript'>alert('Giỏ hàng chưa có sản phẩm'); window.location.href=\"/\"</script>");
            }
            int total = 0;
            foreach (var item in Session["CartSession"] as List<CartItem>)
            {
                total += item.Product.Current_price * item.Quantity;
            }
            Session["TotalPayment"] = total;

            return View();
        }

        [HttpPost]
        public ActionResult Checkout()
        {
            if (!(Session["CartSession"] is List<CartItem> cartItems)
                || !(Session["auth_customer"] is Customer customer)
                || !(Session["TotalPayment"] is int totalPayment))
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);

            if (!OrderService.CreateOrder(customer, cartItems, totalPayment))
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);

            Session["CartSession"] = null;
            return new HttpStatusCodeResult(HttpStatusCode.OK);
        }
    }
}