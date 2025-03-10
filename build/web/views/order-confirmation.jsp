<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Đơn Hàng - Tinh Dầu Thiên Nhiên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="components/header.jsp"></jsp:include>
    
    <!-- Order Confirmation Section -->
    <section class="order-confirmation py-5">
        <div class="container">
            <div class="text-center mb-5">
                <div class="success-icon mb-4">
                    <i class="fas fa-check-circle fa-5x text-success"></i>
                </div>
                <h2 class="mb-3">Đặt hàng thành công!</h2>
                <p class="lead">Cảm ơn bạn đã mua hàng tại Tinh Dầu Thiên Nhiên.</p>
                <p>Đơn hàng #${order.orderID} của bạn đã được tiếp nhận và đang được xử lý.</p>
                <p>Chúng tôi đã gửi thông tin đơn hàng vào email của bạn.</p>
            </div>
            
            <div class="row">
                <div class="col-lg-8 offset-lg-2">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Thông tin đơn hàng #${order.orderID}</h5>
                        </div>
                        <div class="card-body">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <h6 class="text-muted">Thông tin đơn hàng</h6>
                                    <p class="mb-1"><strong>Mã đơn hàng:</strong> #${order.orderID}</p>
                                    <p class="mb-1"><strong>Ngày đặt hàng:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss" /></p>
                                    <p class="mb-1"><strong>Trạng thái:</strong> <span class="badge badge-primary">${order.orderStatus}</span></p>
                                    <p class="mb-1"><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
                                    <p class="mb-0"><strong>Trạng thái thanh toán:</strong> <span class="badge badge-warning">${order.paymentStatus}</span></p>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-muted">Địa chỉ giao hàng</h6>
                                    <p>${order.shippingAddress}</p>
                                </div>
                            </div>
                            
                            <h6 class="text-muted mb-3">Chi tiết sản phẩm</h6>
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th class="text-center">Đơn giá</th>
                                            <th class="text-center">Số lượng</th>
                                            <th class="text-right">Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${order.orderDetails}" var="detail">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="assets/images/products/${detail.product.imageURL}" alt="${detail.product.productName}" width="50" height="50" class="mr-3">
                                                        <div>
                                                            <h6 class="mb-0">${detail.product.productName}</h6>
                                                            <small class="text-muted">${detail.product.productCode}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-center"><fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="" /> VNĐ</td>
                                                                                                <td class="text-center">${detail.quantity}</td>
                                                <td class="text-right">
                                                    <fmt:formatNumber value="${detail.price.multiply(detail.quantity)}" type="currency" currencySymbol="" /> VNĐ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td colspan="3" class="text-right font-weight-bold">Tạm tính:</td>
                                            <td class="text-right">
                                                <fmt:formatNumber value="${order.totalAmount.subtract(30000)}" type="currency" currencySymbol="" /> VNĐ
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="text-right font-weight-bold">Phí vận chuyển:</td>
                                            <td class="text-right">30,000 VNĐ</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="text-right font-weight-bold">Tổng cộng:</td>
                                            <td class="text-right font-weight-bold">
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="" /> VNĐ
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <c:if test="${not empty order.notes}">
                                <div class="mt-4">
                                    <h6 class="text-muted mb-2">Ghi chú đơn hàng</h6>
                                    <p class="mb-0">${order.notes}</p>
                                </div>
                            </c:if>
                            
                            <!-- Payment Instructions -->
                            <c:if test="${order.paymentMethod eq 'bank-transfer' && order.paymentStatus eq 'PENDING'}">
                                <div class="alert alert-info mt-4">
                                    <h6 class="text-info mb-2"><i class="fas fa-info-circle mr-2"></i>Hướng dẫn thanh toán</h6>
                                    <p class="mb-1">Vui lòng chuyển khoản theo thông tin dưới đây:</p>
                                    <p class="mb-1"><strong>Số tài khoản:</strong> 123456789</p>
                                    <p class="mb-1"><strong>Chủ tài khoản:</strong> Công ty Tinh Dầu Thiên Nhiên</p>
                                    <p class="mb-1"><strong>Ngân hàng:</strong> Vietcombank</p>
                                    <p class="mb-1"><strong>Chi nhánh:</strong> Hà Nội</p>
                                    <p class="mb-0"><strong>Nội dung chuyển khoản:</strong> TT ${order.orderID}</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Tiếp tục mua sắm</a>
                        <c:if test="${not empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/account?tab=orders" class="btn btn-outline-primary ml-2">Quản lý đơn hàng</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp"></jsp:include>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        // Print invoice function
        function printInvoice() {
            window.print();
        }
    </script>
</body>
</html>