using Data.Dao;
using Data.Entity;

namespace Data.Service
{
    public class AdminService
    {
        public static Admin CheckLogin(string username, string password)
        {
            var dao = new AdminDao();
            return dao.GetByUsernameAndPassword(username, password);
        }
    }
}
