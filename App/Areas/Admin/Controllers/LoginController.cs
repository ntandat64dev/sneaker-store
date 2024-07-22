using App.Areas.Admin.Models;
using Data.Service;
using System.Web.Mvc;

namespace App.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model)
        {
            if (!ModelState.IsValid) return View("Index");

            var admin = AdminService.CheckLogin(model.Username, model.Password);
            if (admin == null)
            {
                ModelState.AddModelError(string.Empty, "⚠ Tài khoản hoặc mật khẩu không đúng.");
                return View("Index");
            }

            Session["ADMIN_SESSION"] = admin;

            int role = admin.Id_role_admin;

            if (role == 1)
            {
                return RedirectToAction("Index", "AdminHome");
            }
            else if (role == 2)
            {
                return RedirectToAction("Index", "AdminHome");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "⚠ Có lỗi xảy ra.");
                return View("Index");
            }
        }
    }
}