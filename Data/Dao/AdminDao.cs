using Data.Database;
using Data.Entity;
using System;

namespace Data.Dao
{
    public class AdminDao
    {
        public Admin GetByUsernameAndPassword(string username, string password)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT * FROM account_admin " +
                    "WHERE username = @username AND passwordAD = @password";
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    var user = reader.GetString("username");
                    var pass = reader.GetString("passwordAD");
                    var id_role_admin = reader.GetInt32("id_role_admin");
                    var id_status_acc = reader.GetInt32("id_status_acc");
                    var fullname = reader.GetString("fullname");
                    return new Admin(user, pass, id_role_admin, id_status_acc, fullname);
                }
                return null;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                conn.CloseConnection();
            }
        }
    }
}
