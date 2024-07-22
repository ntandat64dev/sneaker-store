using Data.Entity;
using Data.Service;
using PagedList;
using System.Collections.Generic;
using System.Linq;

namespace App.Models
{
    public class ProductsModel
    {
        public IPagedList<Product> ListOfProducts { get; set; }

        public static ProductsModel CreateModel(int id, int pageSize, int? page)
        {
            var list = new List<Product>();
            if (id < 0)
            {
                if (id == -1) list = ProductService.FindGiayProducts();
                else if (id == -2) list = ProductService.FindDepProducts();
                else if (id == -3) list = ProductService.FindPhuKienProducts();
            }
            else
            {
                list = ProductService.FindProductsByTypeId(id);
            }
            return new ProductsModel
            {
                ListOfProducts = list.ToList().ToPagedList(page ?? 1, pageSize)
            };
        }
    }
}