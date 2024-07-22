using System.ComponentModel.DataAnnotations;

namespace App.Areas.Admin.Models
{
    public class AddProductModel
    {
        [Required(ErrorMessage = "Vui lòng nhập tên sản phẩm.")]
        [MinLength(5, ErrorMessage = "Tên sản phẩm phải ít nhất 5 kí tự.")]
        public string NameProduct { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập số lượng sản phẩm.")]
        [Range(0, 10000, ErrorMessage = "Số lượng của sản phẩm phải lớn hơn hoặc bằng 0 và không được vượt quá 10000 sản phẩm.")]
        public int Quantity { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập giá niêm yết của sản phẩm.")]
        [Range(0, 1000000000, ErrorMessage = "Giá của sản phẩm không được âm và không được vượt quá 1 tỉ đồng.")]
        public int ListedPrice { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập giá bán thực tế của sản phẩm.")]
        [Range(0, 1000000000, ErrorMessage = "Giá của sản phẩm không được âm và không được vượt quá 1 tỉ đồng.")]
        public int CurrentPrice { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Vui lòng chọn loại sản phẩm.")]
        public int TypeId { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Vui lòng chọn trạng thái sản phẩm.")]
        public int StatusId { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Vui lòng chọn nhà cung cấp cho sản phẩm.")]
        public int SupplierId { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mô tả của sản phẩm.")]
        [MinLength(20, ErrorMessage = "Mô tả sản phẩm phải ít nhất 20 kí tự.")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Vui lòng thêm hình ảnh cho sản phẩm.")]
        [Range(typeof(bool), "true", "true", ErrorMessage = "Vui lòng thêm hình ảnh cho sản phẩm.")]
        public bool IsImagesAdded { get; set; }
    }
}