using System.ComponentModel.DataAnnotations;

namespace App.Models
{
    public class ConfirmPasswordCustomerModel
    {
        [Required(ErrorMessage = "⚠ Vui lòng nhập mật khẩu mới.")]
        public string NewPassword { get; set; }

        [Required(ErrorMessage = "⚠ Vui lòng xác thực mật khẩu mới.")]
        public string ConfirmNewPassword { get; set; }
    }
}