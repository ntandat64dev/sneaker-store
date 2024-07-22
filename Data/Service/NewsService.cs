using Data.Dao;
using Data.Entity;

namespace Data.Service
{
    public class NewsService
    {
        private static readonly NewsDao _newsDAO = new NewsDao();

        public static bool AddNews(News news, Admin admin) => _newsDAO.InsertNews(news, admin);

        public static News GetNews() => _newsDAO.GetNews();
    }
}
