package utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

public class Validator {
    
    // Validate customer code (KH-XXXX where X is a digit 0-9)
    public static boolean isValidCustomerCode(String code) {
        if (code == null) return false;
        return Pattern.matches("KH-\\d{4}", code);
    }
    
    // Validate service/product code (DV-XXXX where X is a digit 0-9)
    public static boolean isValidProductCode(String code) {
        if (code == null) return false;
        return Pattern.matches("DV-\\d{4}", code);
    }
    
    // Validate phone number
    public static boolean isValidPhoneNumber(String phone) {
        if (phone == null) return false;
        return Pattern.matches("(090|091)\\d{7}|(\\(84\\)\\+9[01])\\d{7}", phone);
    }
    
    // Validate ID card number (9 or 12 digits)
    public static boolean isValidIdCard(String idCard) {
        if (idCard == null) return false;
        return Pattern.matches("\\d{9}|\\d{12}", idCard);
    }
    
    // Validate email
    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        return Pattern.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", email);
    }
    
    // Validate date format (DD/MM/YYYY)
    public static boolean isValidDateFormat(String dateStr) {
        if (dateStr == null) return false;
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        sdf.setLenient(false);
        
        try {
            // Parse the date
            Date date = sdf.parse(dateStr);
            return true;
        } catch (ParseException e) {
            return false;
        }
    }
    
    // Validate positive integer
    public static boolean isPositiveInteger(String numStr) {
        if (numStr == null) return false;
        
        try {
            int num = Integer.parseInt(numStr);
            return num > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    // Validate positive number (decimal)
    public static boolean isPositiveNumber(String numStr) {
        if (numStr == null) return false;
        
        try {
            double num = Double.parseDouble(numStr);
            return num > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}