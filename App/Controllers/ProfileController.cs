using System.Web.Mvc;

namespace App.Controllers
{
    public class ProfileController : Controller
    {
        [Authorize]
        public ActionResult Index()
        {
            return View();
        }
    }
}