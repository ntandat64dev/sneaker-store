﻿using System.ComponentModel.DataAnnotations;

namespace App.Models
{
    public class RegisterCustomerModel
    {
        [Required(ErrorMessage = "⚠ Vui lòng nhập email.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "⚠ Vui lòng mật khẩu.")]
        public string Password { get; set; }

        [Required(ErrorMessage = "⚠ Vui lòng nhập lại mật khẩu.")]
        public string ConfirmPassword { get; set; }
    }
}