namespace Data.Entity
{
    public class Admin
    {
        public string Username { get; set; }
        public string PassAD { get; set; }
        public int Id_role_admin { get; set; }
        public int Id_status_acc { get; set; }
        public string Fullname { get; set; }

        public Admin(string username, string passAD, int id_role_admin, int id_status_acc, string fullname)
        {
            Username = username;
            PassAD = passAD;
            Id_role_admin = id_role_admin;
            Id_status_acc = id_status_acc;
            Fullname = fullname;
        }

        public override string ToString()
        {
            return string.Format("Username={0}, Password={1}, Role={2}, Status={3}, Fullname={4}",
                Username, PassAD, Id_role_admin, Id_status_acc, Fullname);
        }
    }
}
