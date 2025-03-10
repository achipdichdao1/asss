package controller;

import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Product;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }
        
        try {
            switch (action) {
                case "add":
                    addToCart(request, response);
                    break;
                case "update":
                    updateCart(request, response);
                    break;
                case "remove":
                    removeFromCart(request, response);
                    break;
                case "clear":
                    clearCart(request, response);
                    break;
                default:
                    viewCart(request, response);
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
        doGet(request, response);
    }
    
    private void viewCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        int quantity = 1;
        
        if (request.getParameter("quantity") != null) {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }
        
        // Get product from database
        Product product = productDAO.getProductById(productId);
        
        if (product != null) {
            // Check if the requested quantity is available
            if (quantity > product.getStockQuantity()) {
                request.setAttribute("messageType", "danger");
                request.setAttribute("message", "Số lượng yêu cầu vượt quá số lượng trong kho! Chỉ còn " 
                        + product.getStockQuantity() + " sản phẩm.");
                request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
                return;
            }
            
            // Get the cart from session or create new one
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            
            // Add product to cart
            cart.addItem(product, quantity);
            
            // Set success message
            request.setAttribute("messageType", "success");
            request.setAttribute("message", "Sản phẩm đã được thêm vào giỏ hàng!");
            
            // Redirect to previous page or cart page
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.contains("/cart")) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
            }
        } else {
            request.setAttribute("messageType", "danger");
            request.setAttribute("message", "Sản phẩm không tồn tại!");
            request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
        }
    }
    
    private void updateCart(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // Get product from database to check stock
        Product product = productDAO.getProductById(productId);
        
        if (product != null) {
            // Check if the requested quantity is available
            if (quantity > product.getStockQuantity()) {
                request.setAttribute("messageType", "danger");
                request.setAttribute("message", "Số lượng yêu cầu vượt quá số lượng trong kho! Chỉ còn " 
                        + product.getStockQuantity() + " sản phẩm.");
                request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
                return;
            }
            
            // Get the cart from session
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            
            if (cart != null) {
                cart.updateItem(productId, quantity);
            }
            
            response.sendRedirect(request.getContextPath() + "/cart");
        } else {
                        request.setAttribute("messageType", "danger");
            request.setAttribute("message", "Sản phẩm không tồn tại!");
            request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
        }
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        // Get the cart from session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart != null) {
            cart.removeItem(productId);
            
            request.setAttribute("messageType", "success");
            request.setAttribute("message", "Sản phẩm đã được xóa khỏi giỏ hàng!");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the cart from session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart != null) {
            cart.clear();
            
            request.setAttribute("messageType", "success");
            request.setAttribute("message", "Giỏ hàng đã được làm trống!");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}