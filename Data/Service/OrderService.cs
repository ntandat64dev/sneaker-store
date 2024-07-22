using Data.Dao;
using Data.Entity;
using System;
using System.Collections.Generic;

namespace Data.Service
{
    public class OrderService
    {
        private static readonly OrderDao _orderDao = new OrderDao();

        public static List<Order> GetAllOrders() => _orderDao.GetAllOrders();

        public static bool CreateOrder(Customer customer, List<CartItem> cartItems, int totalPayment) => _orderDao.CreateOrder(customer, cartItems, totalPayment);

        public static bool DeleteOrder(int orderId) => _orderDao.DeleteOrder(orderId);

        public static bool UpdateOrderStatus(int orderId, int statusId) => _orderDao.UpdateOrderStatus(orderId, statusId);
    }
}