namespace Data.Entity
{
    public class CartItem
    {
        public Product Product { set; get; }
        public int Quantity { set; get; }

        public CartItem() { }

        public CartItem(Product product, int quantity) {
            Product = product;
            Quantity = quantity;
        }

        public override string ToString()
        {
            return string.Format("Product={{0}}, Quatity={1}",
                Product.ToString(), Quantity);
        }
    }
}