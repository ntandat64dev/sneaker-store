using Data.Dao;
using Data.Entity;

namespace Data.Service
{
    public class CustomerService
    {
        private static readonly CustomerDao _customerDao = new CustomerDao();

        public static Customer CheckLogin(string username, string password) => _customerDao.GetCustomerByUsernameAndPassword(username, password);

        public static bool CheckCustomerExists(string email) => _customerDao.GetCustomerByUsername(email) != null;

        public static bool Register(string email, string password) => _customerDao.CreateUserByUsernameAndPassword(email, password);

        public static bool ChangePassword(string email, string newPassword) => _customerDao.ChangeUserPassword(email, newPassword);
    }
}