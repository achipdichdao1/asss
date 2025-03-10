package controller;

import dao.ProductDAO;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Product;
import utils.Validator;

@WebServlet(name = "ProductController", urlPatterns = {"/products", "/product-detail", "/admin/product"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50) // 50 MB
public class ProductController extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/products":
                    listProducts(request, response);
                    break;
                case "/product-detail":
                    showProductDetail(request, response);
                    break;
                case "/admin/product":
                    String adminAction = request.getParameter("action");
                    if (adminAction == null) {
                        adminAction = "list";
                    }
                    switch (adminAction) {
                        case "list":
                            listProductsForAdmin(request, response);
                            break;
                        case "showForm":
                            showProductForm(request, response);
                            break;
                        case "edit":
                            showEditForm(request, response);
                            break;
                        case "delete":
                            deleteProduct(request, response);
                            break;
                        default:
                            listProductsForAdmin(request, response);
                    }
                    break;
                default:
                    response.sendRedirect("home");
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
        String action = request.getServletPath();

        try {
            if ("/admin/product".equals(action)) {
                String adminAction = request.getParameter("action");
                if (adminAction == null) {
                    adminAction = "list";
                }
                switch (adminAction) {
                    case "add":
                        addProduct(request, response);
                        break;
                    case "update":
                        updateProduct(request, response);
                        break;
                    default:
                        listProductsForAdmin(request, response);
                }
            } else {
                response.sendRedirect("home");
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    // Method to list products for customers
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Get parameters for pagination
        int page = 1;
        int productsPerPage = 12;
        
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        // Get products with pagination
        List<Product> products = productDAO.getProductsWithPagination(page, productsPerPage);
        int totalProducts = productDAO.countTotalProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
        
        // Set attributes for the request
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/views/product-list.jsp").forward(request, response);
    }

    // Method to show product detail
    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);
        
        if (product != null) {
            request.setAttribute("product", product);
            request.getRequestDispatcher("/views/product-detail.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Product not found");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    // Method to list products for admin
    private void listProductsForAdmin(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Get parameters for pagination
        int page = 1;
        int productsPerPage = 10;
        
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        // Get products with pagination
        List<Product> products = productDAO.getProductsWithPagination(page, productsPerPage);
        int totalProducts = productDAO.countTotalProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
        
        // Set attributes for the request
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/views/admin/product-manage.jsp").forward(request, response);
    }

    // Method to show product form for adding new product
    private void showProductForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
    }

    // Method to show edit form
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);
        
        if (product != null) {
            request.setAttribute("product", product);
            request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Product not found");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }

    // Method to add new product
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        // Validate product data
        String productCode = request.getParameter("productCode");
        if (!Validator.isValidProductCode(productCode)) {
            request.setAttribute("error", "Invalid product code format. Should be DV-XXXX where X is a digit 0-9");
            request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
            return;
        }
        
        // Get other parameters
        String productName = request.getParameter("productName");
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String description = request.getParameter("description");
        String usageGuide = request.getParameter("usageGuide");
        String origin = request.getParameter("origin");
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        
        // Handle image upload if provided
        String imageURL = "default.jpg"; // Default image
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("/assets/images/products/");
            filePart.write(uploadPath + fileName);
            imageURL = fileName;
        }
        
        // Create and save the product
        Product product = new Product();
        product.setProductCode(productCode);
        product.setProductName(productName);
        product.setCategoryID(categoryID);
        product.setPrice(price);
        product.setDescription(description);
        product.setUsageGuide(usageGuide);
        product.setOrigin(origin);
        product.setStockQuantity(stockQuantity);
        product.setImageURL(imageURL);
        product.setStatus(true);
        
        boolean result = productDAO.addProduct(product);
        
        if (result) {
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        } else {
            request.setAttribute("error", "Failed to add product");
            request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
        }
    }

    // Method to update product
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("productID"));
        Product existingProduct = productDAO.getProductById(productId);
        
        if (existingProduct != null) {
            // Get parameters
            String productName = request.getParameter("productName");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String description = request.getParameter("description");
            String usageGuide = request.getParameter("usageGuide");
            String origin = request.getParameter("origin");
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            
            // Handle image upload if provided
            String imageURL = existingProduct.getImageURL(); // Keep existing image if not updated
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
                String uploadPath = getServletContext().getRealPath("/assets/images/products/");
                filePart.write(uploadPath + fileName);
                imageURL = fileName;
            }
            
            // Update product
            existingProduct.setProductName(productName);
            existingProduct.setCategoryID(categoryID);
            existingProduct.setPrice(price);
            existingProduct.setDescription(description);
            existingProduct.setUsageGuide(usageGuide);
            existingProduct.setOrigin(origin);
            existingProduct.setStockQuantity(stockQuantity);
            existingProduct.setImageURL(imageURL);
            
            boolean result = productDAO.updateProduct(existingProduct);
            
            if (result) {
                response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
            } else {
                request.setAttribute("error", "Failed to update product");
                request.setAttribute("product", existingProduct);
                request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Product not found");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
    
    // Method to delete product
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int productId = Integer.parseInt(request.getParameter("id"));
        boolean result = productDAO.deleteProduct(productId);
        
        if (result) {
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list");
        } else {
            request.setAttribute("error", "Failed to delete product");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
    
    // Helper method to get file name from Part
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        
        return "";
    }
}