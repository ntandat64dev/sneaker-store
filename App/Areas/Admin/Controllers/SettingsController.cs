using System.Web.Mvc;

namespace App.Areas.Admin.Controllers
{
    public class SettingsController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}