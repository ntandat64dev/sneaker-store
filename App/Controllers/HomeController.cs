using Data.Service;
using System.Web.Mvc;

namespace App.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            Session["giay"] = ProductService.GetGiayTypeProducts();
            Session["dep"] = ProductService.GetDepTypeProducts();
            Session["phu_kien"] = ProductService.GetPhuKienTypeProducts();

            ViewBag.Newest = ProductService.FindNewestProducts();

            ViewBag.FlagshipGiayProducts = ProductService.FindFlagshipGiayProducts();
            ViewBag.FlagshipDepProducts = ProductService.FindFlagshipDepProducts();
            ViewBag.FlagshipPhuKienProducts = ProductService.FindFlagshipPhuKienProducts();

            ViewBag.BestSellingProducts = ProductService.FindBestSellingProducts();
            ViewBag.MostViewsProducts = ProductService.FindMostViewsProducts();
            ViewBag.DiscountProducts = ProductService.FindDiscountProducts();

            ViewBag.DiscountProduct = ProductService.FindDiscountProduct();

            return View();
        }
    }
}