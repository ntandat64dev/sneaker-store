using System.ComponentModel.DataAnnotations;

namespace App.Areas.Admin.Models
{
    public class LoginModel
    {
        [Required(ErrorMessage = "⚠ Vui lòng nhập tên tài khoản.")]
        public string Username { get; set; }

        [Required(ErrorMessage = "⚠ Vui lòng nhập mật khẩu.")]
        public string Password { get; set; }
    }
}