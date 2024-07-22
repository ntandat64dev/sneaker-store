using Data.Database;
using Data.Entity;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace Data.Dao
{
    public class ProductDao
    {
        public List<Product> FindAllProducts() {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "ORDER BY p.date_inserted DESC";
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Product> FindNewestGiayProducts()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "WHERE p.id_type_product BETWEEN 1 AND 9 " +
                    "ORDER BY p.date_inserted DESC " +
                    "LIMIT 5";
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Product> FindFagshipGiayProducts()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT p.*, pp.listed_price, pp.current_price, SUM(sp.quantity_sold) AS quantity_sold FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "LEFT JOIN sold_product AS sp ON sp.id_product = p.id_product " +
                    "WHERE p.id_type_product BETWEEN 1 AND 9 " +
                    "GROUP BY p.id_product, pp.listed_price, pp.current_price " +
                    "ORDER BY quantity_sold DESC " +
                    "LIMIT 8";
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Product> FindFagshipDepProducts()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT p.*, pp.listed_price, pp.current_price, SUM(sp.quantity_sold) AS quantity_sold FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "LEFT JOIN sold_product AS sp ON sp.id_product = p.id_product " +
                    "WHERE p.id_type_product BETWEEN 10 AND 13 " +
                    "GROUP BY p.id_product, pp.listed_price, pp.current_price " +
                    "ORDER BY quantity_sold DESC " +
                    "LIMIT 8";
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Product> FindFagshipPhuKienProducts()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT p.*, pp.listed_price, pp.current_price, SUM(sp.quantity_sold) AS quantity_sold FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "LEFT JOIN sold_product AS sp ON sp.id_product = p.id_product " +
                    "WHERE p.id_type_product > 13 " +
                    "GROUP BY p.id_product, pp.listed_price, pp.current_price " +
                    "ORDER BY quantity_sold DESC " +
                    "LIMIT 8";
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Product> FindDiscountGiayProducts()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT *, (pp.listed_price - pp.current_price) AS discount FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "WHERE p.id_type_product BETWEEN 1 AND 9 " +
                    "ORDER BY discount DESC " +
                    "LIMIT 3";
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Product> FindBestSellingGiayProducts()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "WHERE p.id_product IN(17, 23, 44) " +
                    "LIMIT 3";
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Product> FindMostViewsGiayProducts()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "WHERE p.id_product IN(8, 19, 32) " +
                    "LIMIT 3";
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public Product FindDiscountProduct()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "WHERE p.id_product = 40";
                return EntityReader.ReadProducts(cmd.ExecuteReader()).FirstOrDefault();
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return null;
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<TypeProduct> GetTypeProductsWhereIdBetween(int start, int end)
        {
            var results = new List<TypeProduct>();
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM type_product WHERE id_type_product BETWEEN @start AND @end";
                cmd.Parameters.AddWithValue("@start", start);
                cmd.Parameters.AddWithValue("@end", end);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    var type = new TypeProduct(reader.GetInt32("id_type_product"), reader.GetString("name_type_product"));
                    results.Add(type);
                }
                reader.Close();
                return results;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<TypeProduct>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public Product FindProductById(int id)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "WHERE p.id_product = @id";
                cmd.Parameters.AddWithValue("@id", id);
                return EntityReader.ReadProducts(cmd.ExecuteReader()).FirstOrDefault();
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return null;
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Product> FindProductByTypeRange(int from, int to)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM products AS p " +
                    "JOIN price_product AS pp ON p.id_product = pp.id_product " +
                    "WHERE p.id_type_product BETWEEN @from AND @to";
                cmd.Parameters.AddWithValue("@from", from);
                cmd.Parameters.AddWithValue("@to", to);
                return EntityReader.ReadProducts(cmd.ExecuteReader());
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Product>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<StatusProduct> FindAllStatusProducts()
        {
            var result = new List<StatusProduct>();
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM status_product";
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    var id = reader.GetInt32("id_status_product");
                    var name = reader.GetString("name_status_product");
                    result.Add(new StatusProduct(id, name));
                }
                reader.Close();
                return result;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<StatusProduct>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public List<Supplier> FindAllSuppliers()
        {
            var result = new List<Supplier>();
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM suppliers";
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    int id = reader.GetInt32("id_supplier");
                    string name = reader.GetString("name_supplier");
                    result.Add(new Supplier(id, name));
                }
                reader.Close();
                return result;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Supplier>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public bool InsertProduct(Product product, Admin admin)
        {
            var conn = DbConnection.GetInstance();
            var mysqlConn = conn.GetConnection();
            var trans = mysqlConn.BeginTransaction();

            try
            {
                // Insert Product
                var productCmd = conn.CreateMySqlCommand();
                productCmd.Connection = mysqlConn;
                productCmd.Transaction = trans;
                productCmd.CommandText = "INSERT INTO products (id_type_product, id_status_product, id_supplier, name_product, description_product, url_img_product, quantity_product, star_review, nameAdmin) " +
                    "VALUES (@1, @2, @3, @4, @5, @6, @7, @8, @9)";
                productCmd.Parameters.AddWithValue("@1", product.Id_type);
                productCmd.Parameters.AddWithValue("@2", product.Id_status);
                productCmd.Parameters.AddWithValue("@3", product.Id_supplier);
                productCmd.Parameters.AddWithValue("@4", product.Name_product);
                productCmd.Parameters.AddWithValue("@5", product.Desc_product);
                productCmd.Parameters.AddWithValue("@6", product.Url_img_product);
                productCmd.Parameters.AddWithValue("@7", product.Quantity_product);
                productCmd.Parameters.AddWithValue("@8", 4);
                productCmd.Parameters.AddWithValue("@9", admin.Fullname);
                productCmd.ExecuteNonQuery();
                var insertedProductId = productCmd.LastInsertedId;

                // Insert Price
                var priceCmd = conn.CreateMySqlCommand();
                priceCmd.Connection = mysqlConn;
                priceCmd.Transaction = trans;
                priceCmd.CommandText = "INSERT INTO price_product (id_product, listed_price, current_price, nameAdmin) " +
                    "VALUES (@1, @2, @3, @4)";
                priceCmd.Parameters.AddWithValue("@1", insertedProductId);
                priceCmd.Parameters.AddWithValue("@2", product.Listed_price);
                priceCmd.Parameters.AddWithValue("@3", product.Current_price);
                priceCmd.Parameters.AddWithValue("@4", admin.Fullname);
                var affected = priceCmd.ExecuteNonQuery();

                trans.Commit();
                return affected > 0;    // If insert price success, then insert product should success
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                trans.Rollback();
                return false;
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public bool DeleteProductById(int productId)
        {
            var conn = DbConnection.GetInstance();
            var mysqlConn = conn.GetConnection();
            var trans = mysqlConn.BeginTransaction();

            try
            {
                // Delete Price
                var priceCmd = conn.CreateMySqlCommand();
                priceCmd.Connection = mysqlConn;
                priceCmd.Transaction = trans;
                priceCmd.CommandText = "DELETE FROM price_product WHERE id_product = @id";
                priceCmd.Parameters.AddWithValue("@id", productId);
                priceCmd.ExecuteNonQuery();

                // Delete SoldProduct
                var soldCmd = conn.CreateMySqlCommand();
                soldCmd.Connection = mysqlConn;
                soldCmd.Transaction = trans;
                soldCmd.CommandText = "DELETE FROM sold_product WHERE id_product = @id";
                soldCmd.Parameters.AddWithValue("@id", productId);
                soldCmd.ExecuteNonQuery();

                // Delete BillDetail
                var billDetailCmd = conn.CreateMySqlCommand();
                billDetailCmd.Connection = mysqlConn;
                billDetailCmd.Transaction = trans;
                billDetailCmd.CommandText = "DELETE FROM bill_detail WHERE id_product = @id";
                billDetailCmd.Parameters.AddWithValue("@id", productId);
                billDetailCmd.ExecuteNonQuery();

                // TODO:Delete Bill

                // Delete Product
                var productCmd = conn.CreateMySqlCommand();
                productCmd.Connection = mysqlConn;
                productCmd.Transaction = trans;
                productCmd.CommandText = "DELETE FROM products WHERE id_product = @id";
                productCmd.Parameters.AddWithValue("@id", productId);
                var affected = productCmd.ExecuteNonQuery();

                trans.Commit();
                return affected > 0;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                trans.Rollback();
                return false;
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public bool UpdateProduct(int productId, Product product)
        {
            var conn = DbConnection.GetInstance();
            var mysqlConn = conn.GetConnection();
            var trans = mysqlConn.BeginTransaction();

            try
            {
                // Update Product
                var productCmd = conn.CreateMySqlCommand();
                productCmd.Connection = mysqlConn;
                productCmd.Transaction = trans;
                productCmd.CommandText = "UPDATE products " +
                    "SET name_product = @1, quantity_product = @2, id_status_product = @3, id_type_product = @4 " +
                    "WHERE id_product = @5";
                productCmd.Parameters.AddWithValue("@1", product.Name_product);
                productCmd.Parameters.AddWithValue("@2", product.Quantity_product);
                productCmd.Parameters.AddWithValue("@3", product.Id_status);
                productCmd.Parameters.AddWithValue("@4", product.Id_type);
                productCmd.Parameters.AddWithValue("@5", productId);
                productCmd.ExecuteNonQuery();

                // Update Price
                var priceCmd = conn.CreateMySqlCommand();
                priceCmd.Connection = mysqlConn;
                priceCmd.Transaction = trans;
                priceCmd.CommandText = "UPDATE price_product " +
                    "SET listed_price = @1, current_price = @2 " +
                    "WHERE id_product = @3";
                priceCmd.Parameters.AddWithValue("@1", product.Listed_price);
                priceCmd.Parameters.AddWithValue("@2", product.Current_price);
                priceCmd.Parameters.AddWithValue("@3", productId);
                var affected = priceCmd.ExecuteNonQuery();
                
                trans.Commit();
                return affected > 0;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                trans.Rollback();
                return false;
            }
            finally
            {
                conn.CloseConnection();
            }
        }
    }
}
