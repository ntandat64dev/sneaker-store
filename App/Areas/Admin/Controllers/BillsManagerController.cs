using Data.Service;
using System.Web.Mvc;

namespace App.Areas.Admin.Controllers
{
    public class BillsManagerController : Controller
    {
        public ActionResult Index()
        {
            var orders = OrderService.GetAllOrders();
            ViewBag.Orders = orders;
            return View();
        }

        [HttpPost]
        public ActionResult DeleteOrder(int id)
        {
            if (!OrderService.DeleteOrder(id))
            {
                return new HttpStatusCodeResult(500);
            }
            return new HttpStatusCodeResult(200);
        }

        [HttpPost]
        public ActionResult UpdateOrderStatus(int id, int statusId)
        {
            if (!OrderService.UpdateOrderStatus(id, statusId))
            {
                return new HttpStatusCodeResult(500);
            }
            return new HttpStatusCodeResult(200);
        }
    }
}