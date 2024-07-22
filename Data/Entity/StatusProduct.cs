namespace Data.Entity
{
    public class StatusProduct
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public StatusProduct(int id, string name)
        {
            Id = id;
            Name = name;
        }

        public override string ToString()
        {
            return string.Format("ID={0}, Name={1}", Id, Name);
        }
    }
}
