package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.User;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout", "/order-confirmation"})
public class CheckoutController extends HttpServlet {

    private ProductDAO productDAO;
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String servletPath = request.getServletPath();
        
        try {
            switch (servletPath) {
                case "/checkout":
                    showCheckoutPage(request, response);
                    break;
                case "/order-confirmation":
                    showOrderConfirmation(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/cart");
                    break;
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String servletPath = request.getServletPath();
        
        try {
            switch (servletPath) {
                case "/checkout":
                    processCheckout(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/cart");
                    break;
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
    
    private void showCheckoutPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the cart from session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null || cart.getItemCount() == 0) {
            // Cart is empty, redirect to cart page
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
    }
    
    private void processCheckout(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Get the cart from session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null || cart.getItemCount() == 0) {
            // Cart is empty
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Get user from session if logged in
        User user = (User) session.getAttribute("user");
        int customerId = user != null ? user.getUserID() : 0;
        
        // Get form data
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String shippingMethod = request.getParameter("shippingMethod");
        String paymentMethod = request.getParameter("paymentMethod");
        String notes = request.getParameter("notes");
        
        // Validate form data (simplified)
        if (fullName.isEmpty() || phoneNumber.isEmpty() || email.isEmpty() || address.isEmpty() || 
            province.isEmpty() || district.isEmpty() || ward.isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin giao hàng");
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
            return;
        }
        
        // Calculate shipping fee
        BigDecimal shippingFee;
        switch (shippingMethod) {
            case "express":
                shippingFee = new BigDecimal(45000);
                break;
            case "same-day":
                shippingFee = new BigDecimal(60000);
                break;
            default:
                shippingFee = new BigDecimal(30000);
                break;
        }
        
        // Calculate total amount
        BigDecimal totalAmount = cart.getTotalAmount().add(shippingFee);
        
        // Create full shipping address
        String shippingAddress = address + ", " + ward + ", " + district + ", " + province;
        
        // Create new order
        Order order = new Order();
        order.setCustomerID(customerId);
        order.setOrderDate(Timestamp.valueOf(LocalDateTime.now()));
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setPaymentStatus("PENDING");
        order.setOrderStatus("PROCESSING");
        order.setNotes(notes);
        
        // Create order details
        List<OrderDetail> orderDetails = new ArrayList<>();
        for (Cart.CartItem cartItem : cart.getItems()) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductID(cartItem.getProduct().getProductID());
            orderDetail.setQuantity(cartItem.getQuantity());
            orderDetail.setPrice(cartItem.getProduct().getPrice());
            orderDetail.setDiscount(BigDecimal.ZERO); // No discount in this example
            orderDetail.setProduct(cartItem.getProduct()); // Set product reference
            
            orderDetails.add(orderDetail);
            
            // Update product stock quantity
            Product product = cartItem.getProduct();
            product.setStockQuantity(product.getStockQuantity() - cartItem.getQuantity());
            productDAO.updateProduct(product);
        }
        
        order.setOrderDetails(orderDetails);
        
        // Save order
        int orderId = orderDAO.saveOrder(order);
        
        // Store orderId in session for confirmation page
        session.setAttribute("latestOrderId", orderId);
        
        // Clear the cart
        cart.clear();
        
        // Redirect to confirmation page
        response.sendRedirect(request.getContextPath() + "/order-confirmation");
    }
    
    private void showOrderConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Get the orderId from session
        HttpSession session = request.getSession();
        Integer orderId = (Integer) session.getAttribute("latestOrderId");
        
        if (orderId == null) {
            // No order to confirm
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Get order details
        Order order = orderDAO.getOrderById(orderId);
        
        if (order == null) {
            // Order not found
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Set order in request
        request.setAttribute("order", order);
        
        // Remove orderId from session
        session.removeAttribute("latestOrderId");
        
        // Forward to confirmation page
        request.getRequestDispatcher("/views/order-confirmation.jsp").forward(request, response);
    }
}