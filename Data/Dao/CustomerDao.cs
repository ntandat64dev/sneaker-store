using Data.Database;
using Data.Entity;
using System;
using System.Diagnostics;
using System.Linq;

namespace Data.Dao
{
    public class CustomerDao
    {
        public Customer GetCustomerByUsernameAndPassword(string username, string password)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT *, IFNULL(fullname, username) AS f " +
                    "FROM account_customer " +
                    "WHERE username = @username AND pass = @password";
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                return EntityReader.ReadCustomers(cmd.ExecuteReader()).FirstOrDefault();
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

        public Customer GetCustomerByUsername(string username)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT *, IFNULL(fullname, username) AS f " +
                    "FROM account_customer " +
                    "WHERE username = @username";
                cmd.Parameters.AddWithValue("@username", username);
                return EntityReader.ReadCustomers(cmd.ExecuteReader()).FirstOrDefault();
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

        public bool CreateUserByUsernameAndPassword(string email, string password)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "INSERT INTO account_customer (username, pass, id_status_acc, id_city) " +
                    "VALUES (@email, @password, 1, 1)";
                cmd.Parameters.AddWithValue("email", email);
                cmd.Parameters.AddWithValue("password", password);
                cmd.ExecuteNonQuery();
                return true;
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

        public bool ChangeUserPassword(string email, string newPassword)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "UPDATE account_customer " +
                    "SET pass = @newPassword, time_change_pass = CURRENT_TIMESTAMP() " +
                    "WHERE username = @email";
                cmd.Parameters.AddWithValue("@newPassword", newPassword);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.ExecuteNonQuery();
                return true;
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
    }
}
