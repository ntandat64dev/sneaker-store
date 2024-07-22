using System.ComponentModel.DataAnnotations;

namespace App.Models
{
    public class ChangePassCustomerModel
    {
        [Required(ErrorMessage = "⚠ Vui lòng nhập mật khẩu cũ.")]
        public string OldPassword { get; set; }

        [Required(ErrorMessage = "⚠ Vui lòng nhập mật khẩu mới.")]
        public string NewPassword { get; set; }

        [Required(ErrorMessage = "⚠ Xác nhận lại mật khẩu mới.")]
        public string ConfirmNewPassword { get; set; }
    }
}