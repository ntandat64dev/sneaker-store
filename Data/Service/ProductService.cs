using Data.Dao;
using Data.Entity;
using System.Collections.Generic;
using System.Linq;

namespace Data.Service
{
    public class ProductService
    {
        private static readonly ProductDao _productDao = new ProductDao();

        public static List<Product> FindAllProducts() => _productDao.FindAllProducts();

        public static List<Product> FindNewestProducts() => _productDao.FindNewestGiayProducts();

        public static List<Product> FindFlagshipGiayProducts() => _productDao.FindFagshipGiayProducts();

        public static List<Product> FindFlagshipDepProducts() => _productDao.FindFagshipDepProducts();

        public static List<Product> FindFlagshipPhuKienProducts() => _productDao.FindFagshipPhuKienProducts();

        public static List<Product> FindDiscountProducts() => _productDao.FindDiscountGiayProducts();

        public static List<Product> FindBestSellingProducts() => _productDao.FindBestSellingGiayProducts();

        public static List<Product> FindMostViewsProducts() => _productDao.FindMostViewsGiayProducts();

        public static Product FindDiscountProduct() => _productDao.FindDiscountProduct();

        public static List<TypeProduct> GetGiayTypeProducts() => _productDao.GetTypeProductsWhereIdBetween(1, 9);

        public static List<TypeProduct> GetDepTypeProducts() => _productDao.GetTypeProductsWhereIdBetween(10, 13);

        public static List<TypeProduct> GetPhuKienTypeProducts() => _productDao.GetTypeProductsWhereIdBetween(14, 17);

        public static List<TypeProduct> FindAllTypeProducts() => _productDao.GetTypeProductsWhereIdBetween(1, 17);

        public static Product FindProductById(int id) => _productDao.FindProductById(id);

        public static List<Product> FindGiayProducts() => _productDao.FindProductByTypeRange(1, 9);

        public static List<Product> FindDepProducts() => _productDao.FindProductByTypeRange(10, 13);

        public static List<Product> FindPhuKienProducts() => _productDao.FindProductByTypeRange(14, 17);

        public static List<Product> FindProductsByTypeId(int id) => _productDao.FindProductByTypeRange(id, id);

        public static List<StatusProduct> FindAllStatusProducts() => _productDao.FindAllStatusProducts();

        public static List<Supplier> FindAllSuppliers() => _productDao.FindAllSuppliers();

        public static bool InsertProduct(Product product, Admin admin) => _productDao.InsertProduct(product, admin);

        public static string FindTypeNameById(int typeId)
        {
            var types = _productDao.GetTypeProductsWhereIdBetween(typeId, typeId);
            return types.FirstOrDefault()?.Name;
        }

        public static bool DeleteProductById(int productId) => _productDao.DeleteProductById(productId);

        public static bool UpdateProduct(int productId, Product product) => _productDao.UpdateProduct(productId, product);
    }
}