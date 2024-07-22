using App.Models;
using Data.Entity;
using Data.Service;
using System.Web.Mvc;
using System.Web.Security;

namespace App.Controllers
{
    public class AccountController : Controller
    {
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult RegisterCustomer(RegisterCustomerModel model)
        {
            if (!ModelState.IsValid) return View("Register", model);

            var email = model.Email;
            var password = model.Password;
            var confirmPassword = model.ConfirmPassword;

            if (CustomerService.CheckCustomerExists(email))
            {
                ModelState.AddModelError(string.Empty, "⚠ Tài khoản đã tồn tại!");
                return View("Register", model);
            }

            if (!password.Equals(confirmPassword))
            {
                ModelState.AddModelError(string.Empty, "⚠ Xác thực mật khẩu không hợp lệ!");
                return View("Register", model);
            }

            var isSuccess = CustomerService.Register(email, password);
            if (!isSuccess)
            {
                ModelState.AddModelError(string.Empty, "⚠ Tạo tài khoản thất bại!");
                return View("Register", model);
            }

            return RedirectToAction("Login", "Account");
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult LoginCustomer(LoginCustomerModel model)
        {
            if (!ModelState.IsValid) return View("Login", model);

            var username = model.Username;
            var password = model.Password;
            var customer = CustomerService.CheckLogin(username, password);

            if (customer == null)
            {
                ModelState.AddModelError(string.Empty, "⚠ Email hoặc mật khẩu không đúng!");
                return View("Login", model);
            }

            FormsAuthentication.SetAuthCookie(customer.Username, false);
            Session["auth_customer"] = customer;

            return RedirectToAction("Index", "Home");
        }

        [Authorize]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Remove("auth_customer");
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ForgotPasswordCustomer(ForgotPassCustomerModel model)
        {
            if (!ModelState.IsValid) return View("ForgotPassword", model);

            var email = model.Email;
            if (!CustomerService.CheckCustomerExists(email))
            {
                ModelState.AddModelError(string.Empty, "⚠ Tài khoản không tồn tại trong hệ thống!");
                return View("ForgotPassword", model);
            }

            Session["email_forgot_password"] = email;

            return RedirectToAction("ConfirmPassword", "Account");
        }

        [HttpGet]
        public ActionResult ConfirmPassword()
        {
            if (Session["email_forgot_password"] == null) return RedirectToAction("ForgotPassword", "Account");
            return View();
        }

        [HttpPost]
        public ActionResult ConfirmPasswordCustomer(ConfirmPasswordCustomerModel model)
        {
            if (!ModelState.IsValid) return View("ConfirmPassword", model);

            var inputNewPassword = model.NewPassword;
            var inputConfirmNewPassword = model.ConfirmNewPassword;

            if (!inputNewPassword.Equals(inputConfirmNewPassword))
            {
                ModelState.AddModelError(string.Empty, "⚠ Xác thực mật khẩu không đúng!");
                return View("ConfirmPassword", model);
            }

            var email = Session["email_forgot_password"] as string;

            var isSuccess = CustomerService.ChangePassword(email, inputNewPassword);
            if (!isSuccess)
            {
                ModelState.AddModelError(string.Empty, "⚠ Đổi mật khẩu thất bại!");
                return View("ConfirmPassword", model);
            }

            ViewBag.ChangePasswordResult = true;
            Session.Remove("email_forgot_password");

            return View("ConfirmPassword", model);
        }

        [Authorize]
        [HttpGet]
        public ActionResult ChangePassword()
        {
            return View();
        }

        public ActionResult ChangePasswordAccount(ChangePassCustomerModel model)
        {
            if (!ModelState.IsValid) return View("ChangePassword", model);

            if (!(Session["auth_customer"] is Customer customer)) return RedirectToAction("Login", "Account");

            var password = customer.Password;
            var email = customer.Username;

            var inputOldPassword = model.OldPassword;
            var inputNewPassword = model.NewPassword;
            var inputConfirmPassword = model.ConfirmNewPassword;

            if (!password.Equals(inputOldPassword))
            {
                ModelState.AddModelError(string.Empty, "⚠ Mật khẩu cũ không đúng!");
            }
            else if (!inputNewPassword.Equals(inputConfirmPassword))
            {
                ModelState.AddModelError(string.Empty, "⚠ Xác thực mật khẩu mới không hợp lệ!");
            }
            else if (!CustomerService.ChangePassword(email, inputNewPassword))
            {
                ModelState.AddModelError(string.Empty, "⚠ Đổi mật khẩu thất bại!");
            }
            else
            {
                ViewBag.ChangePasswordResult = true;
            }

            return View("ChangePassword", model);
        }
    }
}