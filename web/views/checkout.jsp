<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - Tinh Dầu Thiên Nhiên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="components/header.jsp"></jsp:include>
    
    <!-- Checkout Section -->
    <section class="checkout-section py-5">
        <div class="container">
            <h2 class="mb-4">Thanh Toán</h2>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                <div class="row">
                    <!-- Billing Information -->
                    <div class="col-lg-8">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Thông tin người mua</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <!-- If user is logged in, pre-fill data -->
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="fullName">Họ và tên</label>
                                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                                       value="${sessionScope.user.fullName}" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="phoneNumber">Số điện thoại</label>
                                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" 
                                                       value="${sessionScope.user.phoneNumber}" required 
                                                       pattern="(090|091)\d{7}|(\(84\)\+9[01])\d{7}">
                                                <div class="invalid-feedback">
                                                    Vui lòng nhập số điện thoại hợp lệ (090xxxxxxx, 091xxxxxxx, (84)+90xxxxxxx hoặc (84)+91xxxxxxx)
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="email">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" 
                                                   value="${sessionScope.user.email}" required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập địa chỉ email hợp lệ
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- If user is not logged in -->
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="fullName">Họ và tên</label>
                                                <input type="text" class="form-control" id="fullName" name="fullName" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="phoneNumber">Số điện thoại</label>
                                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required 
                                                       pattern="(090|091)\d{7}|(\(84\)\+9[01])\d{7}">
                                                <div class="invalid-feedback">
                                                    Vui lòng nhập số điện thoại hợp lệ (090xxxxxxx, 091xxxxxxx, (84)+90xxxxxxx hoặc (84)+91xxxxxxx)
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="email">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập địa chỉ email hợp lệ
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="createAccount" name="createAccount">
                                                <label class="custom-control-label" for="createAccount">
                                                    Tạo tài khoản mới
                                                </label>
                                            </div>
                                        </div>
                                        <div id="accountFields" style="display: none;">
                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label for="username">Tên đăng nhập</label>
                                                    <input type="text" class="form-control" id="username" name="username">
                                                </div>
                                                                                                <div class="col-md-6 mb-3">
                                                    <label for="password">Mật khẩu</label>
                                                    <input type="password" class="form-control" id="password" name="password">
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label for="confirmPassword">Xác nhận mật khẩu</label>
                                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                
                                <hr class="mb-4">
                                <h5 class="mb-3">Địa chỉ giao hàng</h5>
                                
                                <div class="mb-3">
                                    <label for="address">Địa chỉ</label>
                                    <input type="text" class="form-control" id="address" name="address" required>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-5 mb-3">
                                        <label for="province">Tỉnh/Thành phố</label>
                                        <select class="form-control" id="province" name="province" required>
                                            <option value="">Chọn Tỉnh/Thành phố</option>
                                            <option value="Hà Nội">Hà Nội</option>
                                            <option value="TP. Hồ Chí Minh">TP. Hồ Chí Minh</option>
                                            <option value="Đà Nẵng">Đà Nẵng</option>
                                            <option value="Hải Phòng">Hải Phòng</option>
                                            <option value="Cần Thơ">Cần Thơ</option>
                                            <!-- More provinces -->
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="district">Quận/Huyện</label>
                                        <select class="form-control" id="district" name="district" required>
                                            <option value="">Chọn Quận/Huyện</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label for="ward">Phường/Xã</label>
                                        <select class="form-control" id="ward" name="ward" required>
                                            <option value="">Chọn Phường/Xã</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="saveAddress" name="saveAddress">
                                        <label class="custom-control-label" for="saveAddress">
                                            Lưu địa chỉ này cho lần sau
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Shipping Method -->
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Phương thức vận chuyển</h5>
                            </div>
                            <div class="card-body">
                                <div class="custom-control custom-radio mb-3">
                                    <input type="radio" id="standardShipping" name="shippingMethod" class="custom-control-input" value="standard" checked>
                                    <label class="custom-control-label" for="standardShipping">
                                        <strong>Giao hàng tiêu chuẩn (2-3 ngày)</strong> - 30,000 VNĐ
                                    </label>
                                </div>
                                <div class="custom-control custom-radio mb-3">
                                    <input type="radio" id="expressShipping" name="shippingMethod" class="custom-control-input" value="express">
                                    <label class="custom-control-label" for="expressShipping">
                                        <strong>Giao hàng nhanh (1-2 ngày)</strong> - 45,000 VNĐ
                                    </label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="sameDay" name="shippingMethod" class="custom-control-input" value="same-day">
                                    <label class="custom-control-label" for="sameDay">
                                        <strong>Giao hàng trong ngày</strong> - 60,000 VNĐ (chỉ áp dụng cho Hà Nội và TP.HCM)
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Method -->
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Phương thức thanh toán</h5>
                            </div>
                            <div class="card-body">
                                <div class="custom-control custom-radio mb-3">
                                    <input type="radio" id="cod" name="paymentMethod" class="custom-control-input" value="cod" checked>
                                    <label class="custom-control-label" for="cod">
                                        <i class="fas fa-money-bill-wave text-success mr-2"></i>
                                        <strong>Thanh toán khi nhận hàng (COD)</strong>
                                    </label>
                                </div>
                                <div class="custom-control custom-radio mb-3">
                                    <input type="radio" id="bankTransfer" name="paymentMethod" class="custom-control-input" value="bank-transfer">
                                    <label class="custom-control-label" for="bankTransfer">
                                        <i class="fas fa-university text-primary mr-2"></i>
                                        <strong>Chuyển khoản ngân hàng</strong>
                                    </label>
                                    <div class="bank-details ml-4 mt-2" style="display: none;">
                                        <p class="mb-1">Vui lòng chuyển khoản đến:</p>
                                        <p class="mb-1"><strong>Số tài khoản:</strong> 123456789</p>
                                        <p class="mb-1"><strong>Chủ tài khoản:</strong> Công ty Tinh Dầu Thiên Nhiên</p>
                                        <p class="mb-1"><strong>Ngân hàng:</strong> Vietcombank</p>
                                        <p class="mb-0"><strong>Nội dung:</strong> Thanh toán đơn hàng #[Mã đơn hàng]</p>
                                    </div>
                                </div>
                                <div class="custom-control custom-radio mb-3">
                                    <input type="radio" id="creditCard" name="paymentMethod" class="custom-control-input" value="credit-card">
                                    <label class="custom-control-label" for="creditCard">
                                        <i class="fas fa-credit-card text-info mr-2"></i>
                                        <strong>Thẻ tín dụng/Thẻ ghi nợ</strong>
                                    </label>
                                    <div class="credit-card-details ml-4 mt-2" style="display: none;">
                                        <div class="form-group">
                                            <label for="cardNumber">Số thẻ</label>
                                            <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456">
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="expiryDate">Ngày hết hạn</label>
                                                    <input type="text" class="form-control" id="expiryDate" placeholder="MM/YY">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="cvv">CVV</label>
                                                    <input type="text" class="form-control" id="cvv" placeholder="123">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="cardholderName">Tên chủ thẻ</label>
                                            <input type="text" class="form-control" id="cardholderName" placeholder="NGUYEN VAN A">
                                        </div>
                                    </div>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="eWallet" name="paymentMethod" class="custom-control-input" value="e-wallet">
                                    <label class="custom-control-label" for="eWallet">
                                        <i class="fas fa-wallet text-warning mr-2"></i>
                                        <strong>Ví điện tử (Momo, ZaloPay, VNPay)</strong>
                                    </label>
                                    <div class="e-wallet-options ml-4 mt-2" style="display: none;">
                                        <div class="custom-control custom-radio">
                                            <input type="radio" id="momo" name="eWalletType" class="custom-control-input" value="momo">
                                            <label class="custom-control-label" for="momo">
                                                <img src="assets/images/payment/momo.png" alt="MoMo" height="25"> MoMo
                                            </label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" id="zalopay" name="eWalletType" class="custom-control-input" value="zalopay">
                                            <label class="custom-control-label" for="zalopay">
                                                <img src="assets/images/payment/zalopay.png" alt="ZaloPay" height="25"> ZaloPay
                                            </label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" id="vnpay" name="eWalletType" class="custom-control-input" value="vnpay">
                                            <label class="custom-control-label" for="vnpay">
                                                <img src="assets/images/payment/vnpay.png" alt="VNPay" height="25"> VNPay
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order Notes -->
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Ghi chú đơn hàng</h5>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <textarea class="form-control" id="notes" name="notes" rows="3" 
                                              placeholder="Nhập ghi chú đặc biệt cho đơn hàng"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Summary -->
                    <div class="col-lg-4">
                        <div class="card mb-4">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Tóm tắt đơn hàng</h5>
                            </div>
                            <div class="card-body">
                                <div class="order-summary">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Số lượng sản phẩm:</span>
                                        <span>${cart.totalQuantity}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tạm tính:</span>
                                        <span><fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="" /> VNĐ</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Phí vận chuyển:</span>
                                        <span id="shippingFeeDisplay">30,000 VNĐ</span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between mb-2">
                                        <strong>Tổng cộng:</strong>
                                        <strong id="totalAmountDisplay">
                                            <fmt:formatNumber value="${cart.totalAmount + 30000}" type="currency" currencySymbol="" /> VNĐ
                                        </strong>
                                    </div>
                                </div>
                                
                                <hr>
                                
                                <div class="mb-3">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="agreeTerms" name="agreeTerms" required>
                                        <label class="custom-control-label" for="agreeTerms">
                                            Tôi đồng ý với <a href="#" data-toggle="modal" data-target="#termsModal">điều khoản và điều kiện</a> của cửa hàng
                                        </label>
                                        <div class="invalid-feedback">
                                            Bạn phải đồng ý với điều khoản và điều kiện
                                        </div>
                                    </div>
                                </div>
                                
                                <button class="btn btn-primary btn-lg btn-block" type="submit">Đặt Hàng</button>
                                
                                <div class="secure-payment mt-3 text-center">
                                    <i class="fas fa-lock mr-1"></i> Thanh toán an toàn & bảo mật
                                </div>
                                
                                <div class="payment-icons mt-3 text-center">
                                    <img src="assets/images/payment/visa.png" alt="Visa" height="30">
                                    <img src="assets/images/payment/mastercard.png" alt="Mastercard" height="30">
                                    <img src="assets/images/payment/jcb.png" alt="JCB" height="30">
                                    <img src="assets/images/payment/momo.png" alt="MoMo" height="30">
                                    <img src="assets/images/payment/zalopay.png" alt="ZaloPay" height="30">
                                </div>
                                                        </div>
                        </div>

                        <!-- Products List -->
                        <div class="card mb-4">
                            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Sản phẩm trong giỏ</h5>
                                <a class="small" href="${pageContext.request.contextPath}/cart">Chỉnh sửa</a>
                            </div>
                            <div class="card-body p-0">
                                <ul class="list-group list-group-flush">
                                    <c:forEach items="${cart.items}" var="item">
                                        <li class="list-group-item d-flex">
                                            <div class="mr-3">
                                                <span class="badge badge-pill badge-secondary">${item.quantity}</span>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0">${item.product.productName}</h6>
                                                <small class="text-muted">${item.product.productCode}</small>
                                            </div>
                                            <div class="text-right">
                                                <span><fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol="" /> VNĐ</span>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
    
    <!-- Terms and Conditions Modal -->
    <div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="termsModalLabel">Điều khoản và Điều kiện</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h5>1. Chính sách đặt hàng</h5>
                    <p>Khi bạn đặt hàng tại Tinh Dầu Thiên Nhiên, bạn đồng ý cung cấp thông tin chính xác về bản thân và chi tiết liên lạc của bạn.</p>
                    
                    <h5>2. Chính sách vận chuyển</h5>
                    <p>Chúng tôi cam kết giao hàng đúng thời gian đã thông báo. Trong trường hợp có sự chậm trễ, chúng tôi sẽ thông báo cho khách hàng và cập nhật tình trạng đơn hàng.</p>
                    
                    <h5>3. Chính sách đổi trả</h5>
                    <p>Khách hàng có thể đổi trả sản phẩm trong vòng 7 ngày kể từ ngày nhận hàng nếu sản phẩm bị lỗi, hỏng, không đúng mô tả hoặc do lỗi của nhà sản xuất.</p>
                    
                    <h5>4. Bảo mật thông tin</h5>
                    <p>Chúng tôi cam kết bảo mật thông tin cá nhân của khách hàng và không chia sẻ cho bất kỳ bên thứ ba nào ngoại trừ các đối tác vận chuyển để hoàn thành đơn hàng.</p>
                    
                    <h5>5. Phương thức thanh toán</h5>
                    <p>Chúng tôi chấp nhận các phương thức thanh toán như được liệt kê trên trang web. Mọi giao dịch đều được bảo mật theo tiêu chuẩn ngành.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp"></jsp:include>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    
    <script>
        $(document).ready(function() {
            // Form validation
            (function() {
                'use strict';
                window.addEventListener('load', function() {
                    var forms = document.getElementsByClassName('needs-validation');
                    var validation = Array.prototype.filter.call(forms, function(form) {
                        form.addEventListener('submit', function(event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
            
            // Toggle account fields when "Create account" is checked
            $('#createAccount').change(function() {
                if(this.checked) {
                    $('#accountFields').slideDown();
                } else {
                    $('#accountFields').slideUp();
                }
            });
            
            // Toggle payment method details
            $('input[name="paymentMethod"]').change(function() {
                $('.bank-details, .credit-card-details, .e-wallet-options').hide();
                if ($(this).val() === 'bank-transfer') {
                    $('.bank-details').show();
                } else if ($(this).val() === 'credit-card') {
                    $('.credit-card-details').show();
                } else if ($(this).val() === 'e-wallet') {
                    $('.e-wallet-options').show();
                }
            });
            
            // Update shipping fee and total when shipping method changes
            $('input[name="shippingMethod"]').change(function() {
                var shippingCost;
                switch($(this).val()) {
                    case 'express':
                        shippingCost = 45000;
                        break;
                    case 'same-day':
                        shippingCost = 60000;
                        break;
                    default:
                        shippingCost = 30000;
                }
                
                var subtotal = ${cart.totalAmount};
                var total = subtotal + shippingCost;
                
                $('#shippingFeeDisplay').text(shippingCost.toLocaleString() + ' VNĐ');
                $('#totalAmountDisplay').text(total.toLocaleString() + ' VNĐ');
            });
            
            // Initialize flatpickr for date inputs
            flatpickr("#expiryDate", {
                dateFormat: "m/y",
                static: true
            });
            
            // Dynamic location selection (province, district, ward)
            $('#province').change(function() {
                var province = $(this).val();
                if (province) {
                    // This would typically be an AJAX call to get districts for the selected province
                    // For demo purposes, we'll just populate with dummy data
                    $('#district').empty().append('<option value="">Chọn Quận/Huyện</option>');
                    
                    if (province === 'Hà Nội') {
                        $('#district').append('<option value="Ba Đình">Ba Đình</option>');
                        $('#district').append('<option value="Hoàn Kiếm">Hoàn Kiếm</option>');
                        $('#district').append('<option value="Hai Bà Trưng">Hai Bà Trưng</option>');
                        $('#district').append('<option value="Đống Đa">Đống Đa</option>');
                        $('#district').append('<option value="Cầu Giấy">Cầu Giấy</option>');
                    } else if (province === 'TP. Hồ Chí Minh') {
                        $('#district').append('<option value="Quận 1">Quận 1</option>');
                        $('#district').append('<option value="Quận 2">Quận 2</option>');
                        $('#district').append('<option value="Quận 3">Quận 3</option>');
                        $('#district').append('<option value="Quận 7">Quận 7</option>');
                        $('#district').append('<option value="Bình Thạnh">Bình Thạnh</option>');
                    }
                } else {
                    $('#district').empty().append('<option value="">Chọn Quận/Huyện</option>');
                }
                
                $('#ward').empty().append('<option value="">Chọn Phường/Xã</option>');
            });
            
            $('#district').change(function() {
                var district = $(this).val();
                if (district) {
                    // This would typically be an AJAX call to get wards for the selected district
                    // For demo purposes, we'll just populate with dummy data
                    $('#ward').empty().append('<option value="">Chọn Phường/Xã</option>');
                    
                    if (district === 'Ba Đình' || district === 'Quận 1') {
                        $('#ward').append('<option value="Phường 1">Phường 1</option>');
                        $('#ward').append('<option value="Phường 2">Phường 2</option>');
                        $('#ward').append('<option value="Phường 3">Phường 3</option>');
                    } else {
                        $('#ward').append('<option value="Phường A">Phường A</option>');
                        $('#ward').append('<option value="Phường B">Phường B</option>');
                        $('#ward').append('<option value="Phường C">Phường C</option>');
                    }
                } else {
                    $('#ward').empty().append('<option value="">Chọn Phường/Xã</option>');
                }
            });
        });
    </script>
</body>
</html>
                                                