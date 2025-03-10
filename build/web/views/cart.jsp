<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - Tinh Dầu Thiên Nhiên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="components/header.jsp"></jsp:include>
    
    <!-- Cart Section -->
    <section class="cart-section py-5">
        <div class="container">
            <h2 class="mb-4">Giỏ Hàng</h2>
            
            <c:if test="${not empty message}">
                <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>
            
            <c:choose>
                <c:when test="${empty cart.items || cart.itemCount == 0}">
                    <div class="empty-cart text-center py-5">
                        <i class="fas fa-shopping-cart fa-5x text-muted mb-4"></i>
                        <h4 class="mb-3">Giỏ hàng của bạn đang trống</h4>
                        <p class="mb-4">Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Tiếp tục mua sắm</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <!-- Cart Items -->
                        <div class="col-lg-8">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead class="bg-light">
                                                <tr>
                                                    <th scope="col" width="50">#</th>
                                                    <th scope="col" width="100">Ảnh</th>
                                                    <th scope="col">Sản phẩm</th>
                                                    <th scope="col" width="120">Đơn giá</th>
                                                    <th scope="col" width="130">Số lượng</th>
                                                    <th scope="col" width="120">Thành tiền</th>
                                                    <th scope="col" width="50"></th>
                                                </tr>
                                            </thead>
                                                                                        <tbody>
                                                <c:forEach items="${cart.items}" var="item" varStatus="status">
                                                    <tr>
                                                        <th scope="row">${status.index + 1}</th>
                                                        <td>
                                                            <img src="assets/images/products/${item.product.imageURL}" alt="${item.product.productName}" class="img-thumbnail" width="60">
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.productID}" class="text-dark">
                                                                ${item.product.productName}
                                                            </a>
                                                        </td>
                                                        <td class="price">
                                                            <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="" /> VNĐ
                                                        </td>
                                                        <td>
                                                            <form action="${pageContext.request.contextPath}/cart" method="post" class="quantity-form">
                                                                <input type="hidden" name="action" value="update">
                                                                <input type="hidden" name="productId" value="${item.product.productID}">
                                                                <div class="input-group input-group-sm">
                                                                    <div class="input-group-prepend">
                                                                        <button type="button" class="btn btn-outline-secondary update-quantity" data-action="decrease">
                                                                            <i class="fas fa-minus"></i>
                                                                        </button>
                                                                    </div>
                                                                    <input type="number" class="form-control text-center quantity-input" name="quantity" 
                                                                           value="${item.quantity}" min="1" max="${item.product.stockQuantity}" 
                                                                           onchange="this.form.submit()">
                                                                    <div class="input-group-append">
                                                                        <button type="button" class="btn btn-outline-secondary update-quantity" data-action="increase">
                                                                            <i class="fas fa-plus"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </td>
                                                        <td class="subtotal">
                                                            <strong>
                                                                <fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol="" /> VNĐ
                                                            </strong>
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/cart?action=remove&productId=${item.product.productID}" 
                                                               class="btn btn-sm btn-outline-danger remove-item" 
                                                               onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary">
                                    <i class="fas fa-arrow-left mr-2"></i> Tiếp tục mua sắm
                                </a>
                                <a href="${pageContext.request.contextPath}/cart?action=clear" class="btn btn-outline-danger"
                                   onclick="return confirm('Bạn có chắc muốn xóa tất cả sản phẩm khỏi giỏ hàng?')">
                                    <i class="fas fa-trash mr-2"></i> Xóa giỏ hàng
                                </a>
                            </div>
                        </div>
                        
                        <!-- Cart Summary -->
                        <div class="col-lg-4">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="card-title">Tóm tắt đơn hàng</h5>
                                    <hr>
                                    <div class="d-flex justify-content-between mb-3">
                                        <span>Tạm tính (${cart.totalQuantity} sản phẩm):</span>
                                        <span><fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="" /> VNĐ</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <span>Phí vận chuyển:</span>
                                        <span id="shippingFee">30,000 VNĐ</span>
                                    </div>
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="shippingMethod" id="standardShipping" value="standard" checked>
                                            <label class="form-check-label" for="standardShipping">
                                                Giao hàng tiêu chuẩn (2-3 ngày)
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="shippingMethod" id="expressShipping" value="express">
                                            <label class="form-check-label" for="expressShipping">
                                                Giao hàng nhanh (1-2 ngày) - thêm 15,000đ
                                            </label>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="mb-3">
                                        <label for="couponCode">Mã giảm giá</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="couponCode" placeholder="Nhập mã giảm giá">
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button" id="applyCoupon">Áp dụng</button>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between mb-3">
                                        <strong>Tổng cộng:</strong>
                                        <strong id="totalAmount">
                                            <fmt:formatNumber value="${cart.totalAmount + 30000}" type="currency" currencySymbol="" /> VNĐ
                                        </strong>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-block">
                                        Tiến hành thanh toán
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp"></jsp:include>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Update quantity when buttons are clicked
            $('.update-quantity').click(function() {
                var action = $(this).data('action');
                var input = $(this).closest('.input-group').find('.quantity-input');
                var currentValue = parseInt(input.val());
                var maxValue = parseInt(input.attr('max'));
                
                if (action === 'increase' && currentValue < maxValue) {
                    input.val(currentValue + 1);
                    input.closest('form').submit();
                } else if (action === 'decrease' && currentValue > 1) {
                    input.val(currentValue - 1);
                    input.closest('form').submit();
                }
            });
            
            // Update shipping fee and total when shipping method changes
            $('input[name="shippingMethod"]').change(function() {
                var shippingCost = $(this).val() === 'express' ? 45000 : 30000;
                var subtotal = ${cart.totalAmount};
                var total = subtotal + shippingCost;
                
                $('#shippingFee').text(shippingCost.toLocaleString() + ' VNĐ');
                $('#totalAmount').text(total.toLocaleString() + ' VNĐ');
            });
        });
    </script>
</body>
</html>
                                                