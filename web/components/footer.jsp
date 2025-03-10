<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<footer class="footer bg-dark text-light pt-5 pb-3">
    <div class="container">
        <div class="row">
            <!-- Company Info -->
            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                <h5 class="text-uppercase">Tinh Dầu Thiên Nhiên</h5>
                <p>Chuyên cung cấp tinh dầu nguyên chất 100% thiên nhiên, máy khuếch tán và các sản phẩm thơm phòng chất lượng cao.</p>
                <div class="social-links mt-3">
                    <a href="#" class="text-light mr-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-light mr-3"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-light mr-3"><i class="fab fa-youtube"></i></a>
                    <a href="#" class="text-light"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>
            
            <!-- Quick Links -->
            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                <h5 class="text-uppercase">Liên kết nhanh</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/home" class="text-light">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/products" class="text-light">Sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/blog" class="text-light">Blog</a></li>
                    <li><a href="${pageContext.request.contextPath}/about" class="text-light">Giới thiệu</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact" class="text-light">Liên hệ</a></li>
                </ul>
            </div>
            
            <!-- Policies -->
            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                <h5 class="text-uppercase">Chính sách</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-light">Chính sách bảo mật</a></li>
                    <li><a href="#" class="text-light">Chính sách vận chuyển</a></li>
                    <li><a href="#" class="text-light">Chính sách đổi trả</a></li>
                    <li><a href="#" class="text-light">Chính sách thanh toán</a></li>
                    <li><a href="#" class="text-light">Điều khoản sử dụng</a></li>
                </ul>
            </div>
            
            <!-- Contact Info -->
            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                <h5 class="text-uppercase">Thông tin liên hệ</h5>
                <ul class="list-unstyled contact-info">
                    <li class="mb-2"><i class="fas fa-map-marker-alt mr-2"></i> 123 Đường ABC, Quận XYZ, TP. Hà Nội</li>
                    <li class="mb-2"><i class="fas fa-phone-alt mr-2"></i> 1900 123 456</li>
                    <li class="mb-2"><i class="fas fa-envelope mr-2"></i> info@tinhdauthiennhien.com</li>
                    <li><i class="fas fa-clock mr-2"></i> 8:00 - 20:00, Thứ 2 - Chủ nhật</li>
                </ul>
            </div>
        </div>
        
        <hr class="my-4 bg-secondary">
        
        <!-- Bottom Footer -->
        <div class="row align-items-center">
            <div class="col-md-6 mb-3 mb-md-0">
                <p class="mb-0">&copy; 2025 Tinh Dầu Thiên Nhiên. Tất cả quyền được bảo lưu.</p>
            </div>
            <div class="col-md-6 text-md-right">
                <img src="${pageContext.request.contextPath}/assets/images/payment/payment-methods.png" alt="Payment Methods" height="30">
            </div>
        </div>
    </div>
</footer>