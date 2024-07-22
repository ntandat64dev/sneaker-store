using Data.Service;
using System.Web.Mvc;

namespace App.Controllers
{
    public class NewsController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.News = NewsService.GetNews();
            return View();
        }
    }
}