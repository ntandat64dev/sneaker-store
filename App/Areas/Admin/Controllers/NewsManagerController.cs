using App.Areas.Admin.Models;
using Data.Entity;
using Data.Service;
using System.Web.Mvc;

namespace App.Areas.Admin.Controllers
{
    public class NewsManagerController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost, ValidateAntiForgeryToken]
        [ValidateInput(false)]  // Disable dangerous inputs (<, >, etc.) validation.
        public ActionResult AddNews(AddNewsModel model)
        {
            if (!ModelState.IsValid) return View("Index", model);

            var news = new News(model.Title, model.Content);
            var admin = Session["ADMIN_SESSION"] as Data.Entity.Admin;

            var isSuccess = NewsService.AddNews(news, admin);
            if (!isSuccess)
            {
                TempData["NewsAddedResult"] = "failure";
                return View("Index", model);
            }

            TempData["NewsAddedResult"] = "success";
            return RedirectToAction("Index");
        }
    }
}