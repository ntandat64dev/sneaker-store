using System.Web.Mvc;

namespace App.Areas.Admin.Controllers
{
    public class AdminHomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}