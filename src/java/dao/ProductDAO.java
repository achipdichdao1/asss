package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import utils.DBContext;

public class ProductDAO {
    
    // Add a new product
    public boolean addProduct(Product product) throws Exception {
        String sql = "INSERT INTO Product (productCode, productName, categoryID, price, description, " +
                     "usageGuide, origin, stockQuantity, imageURL, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getProductCode());
            ps.setString(2, product.getProductName());
            ps.setInt(3, product.getCategoryID());
            ps.setBigDecimal(4, product.getPrice());
            ps.setString(5, product.getDescription());
            ps.setString(6, product.getUsageGuide());
            ps.setString(7, product.getOrigin());
            ps.setInt(8, product.getStockQuantity());
            ps.setString(9, product.getImageURL());
            ps.setBoolean(10, product.isStatus());
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Update an existing product
    public boolean updateProduct(Product product) throws Exception {
        String sql = "UPDATE Product SET productName = ?, categoryID = ?, price = ?, " +
                     "description = ?, usageGuide = ?, origin = ?, stockQuantity = ?, " +
                     "imageURL = ?, status = ? WHERE productID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, product.getProductName());
            ps.setInt(2, product.getCategoryID());
            ps.setBigDecimal(3, product.getPrice());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getUsageGuide());
            ps.setString(6, product.getOrigin());
            ps.setInt(7, product.getStockQuantity());
            ps.setString(8, product.getImageURL());
            ps.setBoolean(9, product.isStatus());
            ps.setInt(10, product.getProductID());
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Delete a product (or set inactive)
    public boolean deleteProduct(int productId) throws Exception {
        String sql = "UPDATE Product SET status = 0 WHERE productID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        }
    }
    
     // Get product by ID
    public Product getProductById(int productId) throws Exception {
        String sql = "SELECT * FROM Product WHERE productID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapProduct(rs);
            }
        }
        
        return null;
    }
    
    // Get all products
    public List<Product> getAllProducts() throws Exception {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE status = 1";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }
        
        return products;
    }
    
    // Get products by category
    public List<Product> getProductsByCategory(int categoryId) throws Exception {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE categoryID = ? AND status = 1";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }
        
        return products;
    }
    
    // Search products by name
    public List<Product> searchProducts(String keyword) throws Exception {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE productName LIKE ? AND status = 1";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }
        
        return products;
    }
    
    // Get products with pagination
    public List<Product> getProductsWithPagination(int pageNumber, int productsPerPage) throws Exception {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE status = 1 ORDER BY productID " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            int offset = (pageNumber - 1) * productsPerPage;
            ps.setInt(1, offset);
            ps.setInt(2, productsPerPage);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }
        
        return products;
    }
    
    // Count total products
    public int countTotalProducts() throws Exception {
        String sql = "SELECT COUNT(*) FROM Product WHERE status = 1";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        
        return 0;
    }
    
    // Helper method to map ResultSet to Product object
    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductID(rs.getInt("productID"));
        product.setProductCode(rs.getString("productCode"));
        product.setProductName(rs.getString("productName"));
        product.setCategoryID(rs.getInt("categoryID"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setDescription(rs.getString("description"));
        product.setUsageGuide(rs.getString("usageGuide"));
        product.setOrigin(rs.getString("origin"));
        product.setStockQuantity(rs.getInt("stockQuantity"));
        product.setImageURL(rs.getString("imageURL"));
        product.setStatus(rs.getBoolean("status"));
        return product;
    }
}