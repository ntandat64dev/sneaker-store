using System.ComponentModel.DataAnnotations;

namespace App.Models
{
    public class ForgotPassCustomerModel
    {
        [Required(ErrorMessage = "⚠ Vui lòng nhập email.")]
        public string Email { get; set; }
    }
}