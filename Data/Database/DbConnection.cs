using MySql.Data.MySqlClient;

namespace Data.Database
{
    public class DbConnection
    {
        private const string HOST = "127.0.0.1";
        private const int PORT = 3306;
        private const string USERNAME = "root";
        private const string PASSWORD = "0000";
        private const string DATABASE = "sneaker";

        private static DbConnection _instance;
        private readonly MySqlConnection connect;

        private DbConnection()
        {
            connect = new MySqlConnection(string.Format("server={0};port={1};uid={2};pwd={3};database={4}", HOST, PORT, USERNAME, PASSWORD, DATABASE));
            connect.Open();
        }

        public static DbConnection GetInstance()
        {
            if (_instance == null) _instance = new DbConnection();
            return _instance;
        }

        public void CloseConnection()
        {
            connect.Close();
            _instance = null;
        }

        public MySqlCommand CreateMySqlCommand()
        {
            if (connect == null) return null;
            return connect.CreateCommand();
        }

        public MySqlConnection GetConnection()
        {
            return connect;
        }
    }
}
