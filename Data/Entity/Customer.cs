namespace Data.Entity
{
    public class Customer
    {
        public int Id_customer { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public int Id_status_acc { get; set; }
        public int Id_city { get; set; }
        public string Fullname { get; set; }

        public Customer(int id_customer, string username, string password, int id_status_acc, int id_city, string fullname)
        {
            Id_customer = id_customer;
            Username = username;
            Password = password;
            Id_status_acc = id_status_acc;
            Id_city = id_city;
            Fullname = fullname;
        }

        public override string ToString()
        {
            return string.Format("Id={0}, User={1}, Pass={2}, Status={3}, City={4}, Fullname={5}",
               Id_customer, Username, Password, Id_status_acc, Id_city, Fullname);
        }
    }
}
