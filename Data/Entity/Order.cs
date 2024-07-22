using System;
using System.Collections.Generic;
using System.Linq;

namespace Data.Entity
{
    public class Order
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int StatusId { get; set; }
        public int CityId { get; set; }
        public string Fullname { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public int TotalPrice { get; set; }
        public DateTime TimeOrder {  get; set; }
        public List<CartItem> CartItems { get; set; }

        public string GetOrderName() => string.Join(", ", CartItems.Select(e => e.Product.Name_product));

        public int GetQuantity() => CartItems.Sum(e => e.Quantity);
    }
}
