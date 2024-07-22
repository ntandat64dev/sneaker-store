using System.ComponentModel.DataAnnotations;

namespace App.Models
{
    public class LoginCustomerModel
    {
        [Required(ErrorMessage = "⚠ Vui lòng nhập email.")]
        public string Username { get; set; }

        [Required(ErrorMessage = "⚠ Vui lòng nhập mật khẩu.")]
        public string Password { get; set; }
    }
}