using System;

namespace Data.Entity
{
    public class News
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public string Path_image { get; set; }
        public DateTime Date_posted { get; set; }
        public int Quantity_comment { get; set; }

        public News(string title, string content)
        {
            Title = title;
            Content = content;
        }

        public News(int id, string title, string content, DateTime date_posted)
        {
            Id = id;
            Title = title;
            Content = content;
            Date_posted = date_posted;
        }

        public override string ToString()
        {
            return string.Format("Id={0}, Title={1}, Content={2}, Path_image={3}, Date_posted={4}, Quantity_comment={5}",
               Id, Title, Content, Path_image, Date_posted, Quantity_comment);
        }
    }
}
