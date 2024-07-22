using Data.Database;
using Data.Entity;
using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace Data.Dao
{
    public class OrderDao
    {
        public List<Order> GetAllOrders()
        {
            var result = new List<Order>();
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM bills AS b ORDER BY b.time_order DESC";
                var orderReader = cmd.ExecuteReader();
                while (orderReader.Read())
                {
                    var order = new Order()
                    {
                        Id = orderReader.GetInt32("id_bill"),
                        UserId = orderReader.GetInt32("id_user"),
                        StatusId = orderReader.GetInt32("id_status_bill"),
                        CityId = orderReader.GetInt32("id_city"),
                        Fullname = orderReader.GetString("fullname_customer"),
                        Phone = orderReader.GetString("phone_customer"),
                        Email = orderReader.GetString("email_customer"),
                        Address = orderReader.GetString("address_customer"),
                        TotalPrice = orderReader.GetInt32("total_price"),
                        TimeOrder = orderReader.GetDateTime("time_order")
                    };
                    result.Add(order);
                }
                orderReader.Close();

                foreach (var order in result)
                {
                    var cartItems = new List<CartItem>();
                    var billDetailCmd = conn.CreateMySqlCommand();
                    billDetailCmd.CommandText = "SELECT * FROM bill_detail AS bd " +
                        "JOIN products AS p ON bd.id_product = p.id_product " +
                        "WHERE bd.id_bill = @orderId";
                    billDetailCmd.Parameters.AddWithValue("@orderId", order.Id);
                    var billDetailReader = billDetailCmd.ExecuteReader();
                    while (billDetailReader.Read())
                    {
                        var product = new Product
                        {
                            Id_product = billDetailReader.GetInt32("id_product"),
                            Name_product = billDetailReader.GetString("name_product"),
                            Desc_product = billDetailReader.GetString("description_product"),
                            Url_img_product = billDetailReader.GetString("url_img_product"),
                            Id_type = billDetailReader.GetInt32("id_type_product"),
                            Id_status = billDetailReader.GetInt32("id_status_product"),
                            Id_supplier = billDetailReader.GetInt32("id_supplier"),
                            Quantity_product = billDetailReader.GetInt32("quantity_product"),
                            Listed_price = billDetailReader.GetInt32("listed_price"),
                            Current_price = billDetailReader.GetInt32("current_price"),
                            Star = billDetailReader.GetInt32("star_review")
                        };
                        var quantity = billDetailReader.GetInt32("quantity");
                        cartItems.Add(new CartItem(product, quantity));
                    }
                    billDetailReader.Close();
                    order.CartItems = cartItems;
                }

                return result;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return new List<Order>();
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public bool CreateOrder(Customer customer, List<CartItem> cartItems, int totalPayment)
        {
            var conn = DbConnection.GetInstance();
            var mysqlConn = conn.GetConnection();
            var trans = mysqlConn.BeginTransaction();

            try
            {
                // Insert Bill
                var billCmd = conn.CreateMySqlCommand();
                billCmd.Connection = mysqlConn;
                billCmd.Transaction = trans;
                billCmd.CommandText = "INSERT INTO bills (id_user, id_status_bill, id_city, fullname_customer, phone_customer, email_customer, address_customer, bill_price, total_price) " +
                    "VALUES (@1, @2, @3, @4, @5, @6, @7, @8, @9)";
                billCmd.Parameters.AddWithValue("@1", customer.Id_customer);
                billCmd.Parameters.AddWithValue("@2", 1);
                billCmd.Parameters.AddWithValue("@3", customer.Id_city);
                billCmd.Parameters.AddWithValue("@4", customer.Fullname);
                billCmd.Parameters.AddWithValue("@5", "0123456789");
                billCmd.Parameters.AddWithValue("@6", "customer@gmail.com");
                billCmd.Parameters.AddWithValue("@7", "123 ABC st.");
                billCmd.Parameters.AddWithValue("@8", totalPayment);
                billCmd.Parameters.AddWithValue("@9", totalPayment);
                billCmd.ExecuteNonQuery();
                var billId = billCmd.LastInsertedId;

                // Insert BillDetails and SoldProducts
                var affected = 0;
                foreach (var cartItem in cartItems)
                {
                    var bildDetailCmd = conn.CreateMySqlCommand();
                    bildDetailCmd.Connection = mysqlConn;
                    bildDetailCmd.Transaction = trans;
                    bildDetailCmd.CommandText = "INSERT INTO bill_detail (id_bill, id_product, quantity, listed_price, current_price) " +
                        "VALUES (@1, @2, @3, @4, @5)";
                    bildDetailCmd.Parameters.AddWithValue("@1", billId);
                    bildDetailCmd.Parameters.AddWithValue("@2", cartItem.Product.Id_product);
                    bildDetailCmd.Parameters.AddWithValue("@3", cartItem.Quantity);
                    bildDetailCmd.Parameters.AddWithValue("@4", cartItem.Product.Listed_price);
                    bildDetailCmd.Parameters.AddWithValue("@5", cartItem.Product.Current_price);
                    bildDetailCmd.ExecuteNonQuery();

                    var soldProductCmd = conn.CreateMySqlCommand();
                    soldProductCmd.Connection = mysqlConn;
                    soldProductCmd.Transaction = trans;
                    soldProductCmd.CommandText = "INSERT INTO sold_product (id_product, quantity_sold) " +
                        "VALUES (@1, @2)";
                    soldProductCmd.Parameters.AddWithValue("@1", cartItem.Product.Id_product);
                    soldProductCmd.Parameters.AddWithValue("@2", cartItem.Quantity);
                    soldProductCmd.ExecuteNonQuery();

                    var productCmd = conn.CreateMySqlCommand();
                    productCmd.Connection = mysqlConn;
                    productCmd.Transaction = trans;
                    productCmd.CommandText = "UPDATE products SET quantity_product = @1 WHERE id_product = @2";
                    productCmd.Parameters.AddWithValue("@1", cartItem.Product.Quantity_product - cartItem.Quantity);
                    productCmd.Parameters.AddWithValue("@2", cartItem.Product.Id_product);
                    affected += productCmd.ExecuteNonQuery();
                }

                trans.Commit();

                return affected == cartItems.Count;
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

        public bool DeleteOrder(int orderId)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var billDetailCmd = conn.CreateMySqlCommand();
                billDetailCmd.CommandText = "DELETE FROM bill_detail WHERE id_bill = @id";
                billDetailCmd.Parameters.AddWithValue("@id", orderId);
                billDetailCmd.ExecuteNonQuery();

                var billCmd = conn.CreateMySqlCommand();
                billCmd.CommandText = "DELETE FROM bills WHERE id_bill = @id";
                billCmd.Parameters.AddWithValue("@id", orderId);
                var affected = billCmd.ExecuteNonQuery();

                return affected > 0;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return false;
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public bool UpdateOrderStatus(int orderId, int statusId)
        {
            var conn = DbConnection.GetInstance();
            var mysqlConn = conn.GetConnection();
            var trans = mysqlConn.BeginTransaction();

            try
            {
                var productCmd = conn.CreateMySqlCommand();
                productCmd.Connection = mysqlConn;
                productCmd.Transaction = trans;
                productCmd.CommandText = "UPDATE bills " +
                    "SET id_status_bill = @1 " +
                    "WHERE id_bill = @2";
                productCmd.Parameters.AddWithValue("@1", statusId);
                productCmd.Parameters.AddWithValue("@2", orderId);
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
    }
}
