using Data.Database;
using Data.Entity;
using MySql.Data.MySqlClient;
using System;
using System.Diagnostics;

namespace Data.Dao
{
    public class NewsDao
    {
        public bool InsertNews(News news, Admin admin)
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "INSERT INTO news (title_news, content_news, nameAdmin) VALUES (@1, @2, @3)";
                cmd.Parameters.AddWithValue("@1", news.Title);
                cmd.Parameters.AddWithValue("@2", news.Content);
                cmd.Parameters.AddWithValue("@3", admin.Fullname);
                int affected = cmd.ExecuteNonQuery();
                return affected > 0;
            }
            catch (MySqlException e)
            {
                Debug.WriteLine(e.Message);
                return false;
            }
            finally
            {
                conn.CloseConnection();
            }
        }

        public News GetNews()
        {
            var conn = DbConnection.GetInstance();
            try
            {
                var cmd = conn.CreateMySqlCommand();
                cmd.CommandText = "SELECT id_news, title_news, content_news, date_posted " +
                    "FROM news " +
                    "ORDER BY date_posted DESC " +
                    "LIMIT 1;";
                var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    var id = reader.GetInt32("id_news");
                    var title = reader.GetString("title_news");
                    var content = reader.GetString("content_news");
                    var date = reader.GetDateTime("date_posted");
                    return new News(id, title, content, date);
                }
                reader.Close();
                return null;
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
    }
}
