using Data.Entity;
using MySql.Data.MySqlClient;
using System.Collections.Generic;

namespace Data.Dao
{
    public sealed class EntityReader
    {
        public static List<Product> ReadProducts(MySqlDataReader reader)
        {
            var result = new List<Product>();
            while (reader.Read())
            {
                var product = new Product
                {
                    Id_product = reader.GetInt32("id_product"),
                    Name_product = reader.GetString("name_product"),
                    Desc_product = reader.GetString("description_product"),
                    Url_img_product = reader.GetString("url_img_product"),
                    Id_type = reader.GetInt32("id_type_product"),
                    Id_status = reader.GetInt32("id_status_product"),
                    Id_supplier = reader.GetInt32("id_supplier"),
                    Quantity_product = reader.GetInt32("quantity_product"),
                    Listed_price = reader.GetInt32("listed_price"),
                    Current_price = reader.GetInt32("current_price"),
                    Star = reader.GetInt32("star_review")
                };
                result.Add(product);
            }
            reader.Close();
            return result;
        }

        public static List<Customer> ReadCustomers(MySqlDataReader reader)
        {
            var result = new List<Customer>();
            while (reader.Read())
            {
                var IdCustomer = reader.GetInt32("id_user_customer");
                var Username = reader.GetString("username");
                var Pass = reader.GetString("pass");
                var IdStatusAcc = reader.GetInt32("id_status_acc");
                var IdCity = reader.GetInt32("id_city");
                var Fullname = reader.GetString("f");
                result.Add(new Customer(IdCustomer, Username, Pass, IdStatusAcc, IdCity, Fullname));
            }
            reader.Close();

            return result;
        }
    }
}
