package model;

import java.math.BigDecimal;

public class Product {
    private int productID;
    private String productCode;
    private String productName;
    private int categoryID;
    private BigDecimal price;
    private String description;
    private String usageGuide;
    private String origin;
    private int stockQuantity;
    private String imageURL;
    private boolean status;
    
    // Constructors
    public Product() {
    }
    
    public Product(int productID, String productCode, String productName, int categoryID, 
            BigDecimal price, String description, String usageGuide, String origin, 
            int stockQuantity, String imageURL, boolean status) {
        this.productID = productID;
        this.productCode = productCode;
        this.productName = productName;
        this.categoryID = categoryID;
        this.price = price;
        this.description = description;
        this.usageGuide = usageGuide;
        this.origin = origin;
        this.stockQuantity = stockQuantity;
        this.imageURL = imageURL;
        this.status = status;
    }
    
    // Getters and Setters
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUsageGuide() {
        return usageGuide;
    }

    public void setUsageGuide(String usageGuide) {
        this.usageGuide = usageGuide;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}