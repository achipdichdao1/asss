package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/admin/*"})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession(false);
        
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isAdminOrManager = false;
        
        if (isLoggedIn) {
            User user = (User) session.getAttribute("user");
            isAdminOrManager = "ADMIN".equals(user.getRole()) || "MANAGER".equals(user.getRole());
        }
        
        String requestURI = request.getRequestURI();
        
        if (isLoggedIn && isAdminOrManager) {
            // Admin or Manager can access admin pages
            chain.doFilter(request, response);
        } else if (isLoggedIn && !isAdminOrManager && requestURI.contains("/admin/")) {
            // Other users cannot access admin pages
            response.sendRedirect(request.getContextPath() + "/access-denied");
        } else if (!isLoggedIn && requestURI.contains("/admin/")) {
            // Redirect to login page if trying to access admin pages without login
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Allow access to public pages
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}