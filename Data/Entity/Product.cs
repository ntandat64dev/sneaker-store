namespace Data.Entity
{
    public class Product
    {
        public int Id_product { get; set; }
        public string Name_product { get; set; }
        public string Desc_product { get; set; }
        public string Url_img_product { get; set; }
        public int Quantity_product { get; set; }
        public int Id_type { get; set; }
        public int Id_status { get; set; }
        public int Id_supplier { get; set; }
        public int Listed_price { get; set; }
        public int Current_price { get; set; }
        public int Star { get; set; }

        public Product() { }

        public Product(string name_product, string desc_product, string url_img_product,
            int quantity_product, int id_type, int id_status, int id_supplier)
        {
            Name_product = name_product;
            Desc_product = desc_product;
            Url_img_product = url_img_product;
            Quantity_product = quantity_product;
            Id_type = id_type;
            Id_status = id_status;
            Id_supplier = id_supplier;
        }

        public Product(string name_product, string desc_product, string url_img_product,
            int quantity_product, int id_type, int id_status, int id_supplier, int listed_price, int current_price
        ) : this(name_product, desc_product, url_img_product, quantity_product, id_type, id_status, id_supplier)
        {
            Listed_price = listed_price;
            Current_price = current_price;
        }

        public Product(int id_product, int listed_price, int current_price)
        {
            Id_product = id_product;
            Listed_price = listed_price;
            Current_price = current_price;
        }

        public override string ToString()
        {
            return string.Format("ID={0}, Name={1}, Desc={2}, ImageUrl={3}, Quantity={4}, IdType={5}, IdStatus={6}, IdSuplier={7}",
                Id_product, Name_product, Desc_product, Url_img_product, Quantity_product, Id_type, Id_status, Id_supplier);
        }
    }
}
