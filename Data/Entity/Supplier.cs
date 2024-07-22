namespace Data.Entity
{
    public class Supplier
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public Supplier(int id, string name)
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
