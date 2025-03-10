package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private List<CartItem> items;
    
    public Cart() {
        this.items = new ArrayList<>();
    }
    
    public void addItem(Product product, int quantity) {
        for (CartItem item : items) {
            if (item.getProduct().getProductID() == product.getProductID()) {
                // Product already exists in cart, update quantity
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        
        // Product doesn't exist in cart, add as new item
        CartItem newItem = new CartItem(product, quantity);
        items.add(newItem);
    }
    
    public void updateItem(int productId, int quantity) {
        for (CartItem item : items) {
            if (item.getProduct().getProductID() == productId) {
                if (quantity <= 0) {
                    removeItem(productId);
                    return;
                }
                item.setQuantity(quantity);
                return;
            }
        }
    }
    
    public void removeItem(int productId) {
        Iterator<CartItem> iterator = items.iterator();
        while (iterator.hasNext()) {
            CartItem item = iterator.next();
            if (item.getProduct().getProductID() == productId) {
                iterator.remove();
                return;
            }
        }
    }
    
    public void clear() {
        items.clear();
    }
    
    public List<CartItem> getItems() {
        return items;
    }
    
    public int getItemCount() {
        return items.size();
    }
    
    public int getTotalQuantity() {
        int totalQuantity = 0;
        for (CartItem item : items) {
            totalQuantity += item.getQuantity();
        }
        return totalQuantity;
    }
    
    public BigDecimal getTotalAmount() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.getSubTotal());
        }
        return total;
    }
    
    public static class CartItem implements Serializable {
        private static final long serialVersionUID = 1L;
        
        private Product product;
        private int quantity;
        
        public CartItem(Product product, int quantity) {
            this.product = product;
            this.quantity = quantity;
        }
        
        public Product getProduct() {
            return product;
        }
        
        public int getQuantity() {
            return quantity;
        }
        
        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
        
        public BigDecimal getSubTotal() {
            return product.getPrice().multiply(new BigDecimal(quantity));
        }
    }
}