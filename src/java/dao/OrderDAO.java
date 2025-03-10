package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.Product;
import utils.DBContext;

public class OrderDAO {
    
    private ProductDAO productDAO;
    
    public OrderDAO() {
        productDAO = new ProductDAO();
    }
    
    // Save order and return generated order ID
    public int saveOrder(Order order) throws Exception {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetail = null;
        ResultSet rs = null;
        int orderId = -1;
        
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);
            
            // Insert into Order table
            String sqlOrder = "INSERT INTO [Order] (customerID, orderDate, totalAmount, " +
                              "shippingAddress, paymentMethod, paymentStatus, orderStatus, notes) " +
                              "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getCustomerID());
            psOrder.setTimestamp(2, order.getOrderDate());
            psOrder.setBigDecimal(3, order.getTotalAmount());
            psOrder.setString(4, order.getShippingAddress());
            psOrder.setString(5, order.getPaymentMethod());
            psOrder.setString(6, order.getPaymentStatus());
            psOrder.setString(7, order.getOrderStatus());
            psOrder.setString(8, order.getNotes());
            
            int affectedRows = psOrder.executeUpdate();
            
            if (affectedRows == 0) {
                throw new Exception("Creating order failed, no rows affected.");
            }
            
            rs = psOrder.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            } else {
                throw new Exception("Creating order failed, no ID obtained.");
            }
            
            // Insert into OrderDetail table
            String sqlDetail = "INSERT INTO OrderDetail (orderID, productID, quantity, price, discount) " +
                               "VALUES (?, ?, ?, ?, ?)";
            
            psDetail = conn.prepareStatement(sqlDetail);
            
            for (OrderDetail detail : order.getOrderDetails()) {
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, detail.getProductID());
                psDetail.setInt(3, detail.getQuantity());
                psDetail.setBigDecimal(4, detail.getPrice());
                psDetail.setBigDecimal(5, detail.getDiscount() != null ? detail.getDiscount() : BigDecimal.ZERO);
                
                psDetail.addBatch();
            }
            
            psDetail.executeBatch();
            
            conn.commit();
            
            return orderId;
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception ex) {
                    throw new Exception("Error during transaction rollback: " + ex.getMessage());
                }
            }
            throw new Exception("Error saving order: " + e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (psDetail != null) {
                psDetail.close();
            }
            if (psOrder != null) {
                psOrder.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
    
    // Get order by ID
    public Order getOrderById(int orderId) throws Exception {
        Order order = null;
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetails = null;
        ResultSet rsOrder = null;
        ResultSet rsDetails = null;
        
        try {
            conn = DBContext.getConnection();
            
            // Get order info
            String sqlOrder = "SELECT * FROM [Order] WHERE orderID = ?";
            psOrder = conn.prepareStatement(sqlOrder);
            psOrder.setInt(1, orderId);
            rsOrder = psOrder.executeQuery();
            
            if (rsOrder.next()) {
                order = new Order();
                order.setOrderID(rsOrder.getInt("orderID"));
                order.setCustomerID(rsOrder.getInt("customerID"));
                order.setOrderDate(rsOrder.getTimestamp("orderDate"));
                order.setTotalAmount(rsOrder.getBigDecimal("totalAmount"));
                order.setShippingAddress(rsOrder.getString("shippingAddress"));
                order.setPaymentMethod(rsOrder.getString("paymentMethod"));
                order.setPaymentStatus(rsOrder.getString("paymentStatus"));
                order.setOrderStatus(rsOrder.getString("orderStatus"));
                order.setNotes(rsOrder.getString("notes"));
                
                // Get order details
                String sqlDetails = "SELECT * FROM OrderDetail WHERE orderID = ?";
                psDetails = conn.prepareStatement(sqlDetails);
                psDetails.setInt(1, orderId);
                rsDetails = psDetails.executeQuery();
                
                List<OrderDetail> details = new ArrayList<>();
                while (rsDetails.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderDetailID(rsDetails.getInt("orderDetailID"));
                    detail.setOrderID(rsDetails.getInt("orderID"));
                    detail.setProductID(rsDetails.getInt("productID"));
                    detail.setQuantity(rsDetails.getInt("quantity"));
                    detail.setPrice(rsDetails.getBigDecimal("price"));
                    detail.setDiscount(rsDetails.getBigDecimal("discount"));
                    
                    // Get product
                    Product product = productDAO.getProductById(detail.getProductID());
                    detail.setProduct(product);
                    
                                        details.add(detail);
                }
                
                order.setOrderDetails(details);
            }
            
            return order;
        } finally {
            if (rsDetails != null) {
                rsDetails.close();
            }
            if (psDetails != null) {
                psDetails.close();
            }
            if (rsOrder != null) {
                rsOrder.close();
            }
            if (psOrder != null) {
                psOrder.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    // Get orders by customer ID
    public List<Order> getOrdersByCustomerId(int customerId) throws Exception {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT * FROM [Order] WHERE customerID = ? ORDER BY orderDate DESC";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerID(rs.getInt("customerID"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalAmount(rs.getBigDecimal("totalAmount"));
                order.setShippingAddress(rs.getString("shippingAddress"));
                order.setPaymentMethod(rs.getString("paymentMethod"));
                order.setPaymentStatus(rs.getString("paymentStatus"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setNotes(rs.getString("notes"));
                
                // We don't load details here to improve performance
                orders.add(order);
            }
            
            return orders;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    // Update order status
    public boolean updateOrderStatus(int orderId, String status) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "UPDATE [Order] SET orderStatus = ? WHERE orderID = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    // Update payment status
    public boolean updatePaymentStatus(int orderId, String status) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "UPDATE [Order] SET paymentStatus = ? WHERE orderID = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    // Get all orders for admin
    public List<Order> getAllOrders() throws Exception {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT o.*, u.fullName as customerName FROM [Order] o " +
                         "LEFT JOIN [User] u ON o.customerID = u.userID " +
                         "ORDER BY o.orderDate DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerID(rs.getInt("customerID"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalAmount(rs.getBigDecimal("totalAmount"));
                order.setShippingAddress(rs.getString("shippingAddress"));
                order.setPaymentMethod(rs.getString("paymentMethod"));
                order.setPaymentStatus(rs.getString("paymentStatus"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setNotes(rs.getString("notes"));
                order.setCustomerName(rs.getString("customerName")); // Add customer name for display
                
                orders.add(order);
            }
            
            return orders;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    // Get recent orders for dashboard
    public List<Order> getRecentOrders(int limit) throws Exception {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT TOP (?) o.*, u.fullName as customerName FROM [Order] o " +
                         "LEFT JOIN [User] u ON o.customerID = u.userID " +
                         "ORDER BY o.orderDate DESC";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerID(rs.getInt("customerID"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalAmount(rs.getBigDecimal("totalAmount"));
                order.setShippingAddress(rs.getString("shippingAddress"));
                order.setPaymentMethod(rs.getString("paymentMethod"));
                order.setPaymentStatus(rs.getString("paymentStatus"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setNotes(rs.getString("notes"));
                order.setCustomerName(rs.getString("customerName"));
                
                orders.add(order);
            }
            
            return orders;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    // Get orders by status
    public List<Order> getOrdersByStatus(String status) throws Exception {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT o.*, u.fullName as customerName FROM [Order] o " +
                         "LEFT JOIN [User] u ON o.customerID = u.userID " +
                         "WHERE o.orderStatus = ? " +
                         "ORDER BY o.orderDate DESC";
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("orderID"));
                order.setCustomerID(rs.getInt("customerID"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                order.setTotalAmount(rs.getBigDecimal("totalAmount"));
                order.setShippingAddress(rs.getString("shippingAddress"));
                order.setPaymentMethod(rs.getString("paymentMethod"));
                order.setPaymentStatus(rs.getString("paymentStatus"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setNotes(rs.getString("notes"));
                order.setCustomerName(rs.getString("customerName"));
                
                orders.add(order);
            }
            
            return orders;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    // Get revenue statistics by date range
    public List<Object[]> getRevenueStatsByDateRange(Timestamp startDate, Timestamp endDate) throws Exception {
        List<Object[]> stats = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT CAST(orderDate AS DATE) as orderDay, " +
                         "COUNT(orderID) as totalOrders, " +
                         "SUM(totalAmount) as totalRevenue " +
                         "FROM [Order] " +
                         "WHERE orderDate BETWEEN ? AND ? " +
                         "GROUP BY CAST(orderDate AS DATE) " +
                         "ORDER BY orderDay";
            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, startDate);
            ps.setTimestamp(2, endDate);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Object[] stat = new Object[3];
                stat[0] = rs.getDate("orderDay");
                stat[1] = rs.getInt("totalOrders");
                stat[2] = rs.getBigDecimal("totalRevenue");
                
                stats.add(stat);
            }
            
            return stats;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
}
                
                