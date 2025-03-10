<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - Tinh Dầu Thiên Nhiên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="components/header.jsp"></jsp:include>
    
    <!-- Product Detail Section -->
    <section class="product-detail py-5">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent px-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
                </ol>
            </nav>
            
            <div class="row">
                <!-- Product Images -->
                <div class="col-md-5 mb-4">
                    <div class="product-image">
                        <img src="assets/images/products/${product.imageURL}" class="img-fluid" alt="${product.productName}">
                    </div>
                </div>
                
                <!-- Product Information -->
                <div class="col-md-7">
                    <h2>${product.productName}</h2>
                    <div class="product-rating mb-3">
                        <span class="text-warning">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </span>
                        <span class="ml-2">(4.5/5) - 28 đánh giá</span>
                    </div>
                    <p class="product-price mb-3">${product.price} VNĐ</p>
                    <p class="product-status mb-3">
                        <span class="badge ${product.stockQuantity > 0 ? 'badge-success' : 'badge-danger'}">
                            ${product.stockQuantity > 0 ? 'Còn hàng' : 'Hết hàng'}
                        </span>
                    </p>
                    <p class="product-origin mb-3">
                        <strong>Xuất xứ:</strong> ${product.origin}
                    </p>
                    <div class="product-description mb-4">
                        <h5>Mô tả sản phẩm</h5>
                        <p>${product.description}</p>
                    </div>
                    <div class="product-usage mb-4">
                        <h5>Hướng dẫn sử dụng</h5>
                        <p>${product.usageGuide}</p>
                    </div>
                    <form action="${pageContext.request.contextPath}/cart" method="get" class="d-flex mb-4">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="id" value="${product.productID}">
                        <div class="form-group mr-3 mb-0">
                            <div class="input-group" style="width: 130px;">
                                <div class="input-group-prepend">
                                    <button type="button" class="btn btn-outline-secondary btn-sm quantity-btn" data-action="decrease">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                                <input type="number" class="form-control text-center quantity-input" name="quantity" value="1" min="1" max="${product.stockQuantity}">
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-outline-secondary btn-sm quantity-btn" data-action="increase">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg" ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fas fa-shopping-cart mr-2"></i> Thêm vào giỏ
                        </button>
                    </form>
                    <div class="product-meta">
                        <p><i class="fas fa-shield-alt mr-2"></i> Bảo đảm chất lượng</p>
                        <p><i class="fas fa-truck mr-2"></i> Vận chuyển nhanh chóng</p>
                        <p><i class="fas fa-exchange-alt mr-2"></i> Đổi trả trong vòng 7 ngày</p>
                    </div>
                </div>
            </div>
            
            <!-- Product Tabs -->
            <div class="row mt-5">
                <div class="col-12">
                    <ul class="nav nav-tabs" id="productTabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="details-tab" data-toggle="tab" href="#details" role="tab" aria-controls="details" aria-selected="true">Chi Tiết Sản Phẩm</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="reviews-tab" data-toggle="tab" href="#reviews" role="tab" aria-controls="reviews" aria-selected="false">Đánh Giá</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="shipping-tab" data-toggle="tab" href="#shipping" role="tab" aria-controls="shipping" aria-selected="false">Vận Chuyển & Đổi Trả</a>
                        </li>
                    </ul>
                    <div class="tab-content p-4 border border-top-0" id="productTabsContent">
                        <div class="tab-pane fade show active" id="details" role="tabpanel" aria-labelledby="details-tab">
                            <h4>Thông tin chi tiết</h4>
                            <table class="table table-striped">
                                <tbody>
                                    <tr>
                                        <th width="30%">Mã sản phẩm</th>
                                        <td>${product.productCode}</td>
                                    </tr>
                                    <tr>
                                        <th>Xuất xứ</th>
                                        <td>${product.origin}</td>
                                    </tr>
                                    <tr>
                                        <th>Dung tích</th>
                                        <td>10ml</td>
                                    </tr>
                                    <tr>
                                        <th>Thành phần</th>
                                        <td>100% tinh dầu thiên nhiên nguyên chất</td>
                                    </tr>
                                    <tr>
                                        <th>Công dụng</th>
                                        <td>
                                            <ul>
                                                <li>Thư giãn, giảm căng thẳng</li>
                                                <li>Thanh lọc không khí</li>
                                                <li>Cải thiện giấc ngủ</li>
                                                <li>Giảm đau đầu, mệt mỏi</li>
                                            </ul>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                            <!-- Reviews -->
                            <div class="reviews">
                                <h4>Đánh giá từ khách hàng</h4>
                                <div class="review-item p-3 mb-3 border-bottom">
                                    <div class="d-flex align-items-center mb-2">
                                        <img src="assets/images/avatar1.jpg" class="rounded-circle mr-3" width="50" height="50" alt="User 1">
                                        <div>
                                            <h5 class="mb-0">Trần Minh</h5>
                                            <div class="text-warning">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                            </div>
                                            <small class="text-muted">Ngày 05/01/2025</small>
                                        </div>
                                    </div>
                                    <p>Sản phẩm rất tốt, mùi hương dễ chịu và kéo dài. Đóng gói cẩn thận, giao hàng nhanh. Tôi rất hài lòng và sẽ mua thêm các sản phẩm khác.</p>
                                </div>
                                <div class="review-item p-3 mb-3 border-bottom">
                                    <div class="d-flex align-items-center mb-2">
                                        <img src="assets/images/avatar2.jpg" class="rounded-circle mr-3" width="50" height="50" alt="User 2">
                                        <div>
                                            <h5 class="mb-0">Nguyễn Thảo</h5>
                                            <div class="text-warning">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="far fa-star"></i>
                                            </div>
                                            <small class="text-muted">Ngày 28/12/2024</small>
                                        </div>
                                    </div>
                                    <p>Tinh dầu mùi thơm nhẹ nhàng, dễ chịu. Tuy nhiên, tôi hy vọng mùi hương có thể bền lâu hơn một chút. Nhìn chung vẫn là sản phẩm tốt.</p>
                                </div>
                                
                                <!-- Add Review Form -->
                                <div class="add-review mt-4">
                                    <h4>Viết đánh giá của bạn</h4>
                                    <form>
                                        <div class="form-group">
                                            <label>Đánh giá</label>
                                            <div class="rating">
                                                <i class="far fa-star rating-star" data-value="1"></i>
                                                <i class="far fa-star rating-star" data-value="2"></i>
                                                <i class="far fa-star rating-star" data-value="3"></i>
                                                <i class="far fa-star rating-star" data-value="4"></i>
                                                <i class="far fa-star rating-star" data-value="5"></i>
                                            </div>
                                            <input type="hidden" name="rating" id="ratingValue">
                                        </div>
                                        <div class="form-group">
                                            <label for="reviewText">Nội dung đánh giá</label>
                                                                                        <textarea class="form-control" id="reviewText" name="reviewText" rows="4" required></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Gửi Đánh Giá</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="shipping" role="tabpanel" aria-labelledby="shipping-tab">
                            <h4>Chính sách vận chuyển</h4>
                            <p>Chúng tôi cung cấp các hình thức vận chuyển sau:</p>
                            <ul>
                                <li>Giao hàng tiêu chuẩn: 2-3 ngày làm việc (miễn phí cho đơn hàng trên 300.000đ)</li>
                                <li>Giao hàng nhanh: 1-2 ngày làm việc (phụ phí 30.000đ)</li>
                                <li>Giao hàng hỏa tốc: Trong ngày (chỉ áp dụng cho nội thành Hà Nội và TP.HCM, phụ phí 50.000đ)</li>
                            </ul>
                            
                            <h4 class="mt-4">Chính sách đổi trả</h4>
                            <p>Quý khách có thể đổi trả sản phẩm trong các trường hợp sau:</p>
                            <ul>
                                <li>Sản phẩm bị lỗi do nhà sản xuất</li>
                                <li>Sản phẩm không đúng với mô tả</li>
                                <li>Sản phẩm chưa qua sử dụng và còn nguyên tem, mác, bao bì</li>
                            </ul>
                            <p>Thời gian đổi trả: trong vòng 7 ngày kể từ ngày nhận hàng</p>
                            <p>Để biết thêm chi tiết, vui lòng liên hệ với chúng tôi qua hotline: <strong>1900 1234</strong></p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Related Products -->
            <div class="related-products mt-5">
                <h3 class="mb-4">Sản Phẩm Liên Quan</h3>
                <div class="row">
                    <c:forEach items="${relatedProducts}" var="relatedProduct">
                        <div class="col-md-3 mb-4">
                            <div class="card h-100 product-card">
                                <img src="assets/images/products/${relatedProduct.imageURL}" class="card-img-top" alt="${relatedProduct.productName}">
                                <div class="card-body">
                                    <h5 class="card-title">${relatedProduct.productName}</h5>
                                    <p class="card-text price">${relatedProduct.price} VNĐ</p>
                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${relatedProduct.productID}" class="btn btn-outline-primary">Chi Tiết</a>
                                        <a href="${pageContext.request.contextPath}/cart?action=add&id=${relatedProduct.productID}" class="btn btn-primary">Thêm Vào Giỏ</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
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
        // Quantity input handling
        $(document).ready(function() {
            $('.quantity-btn').click(function() {
                var action = $(this).data('action');
                var input = $(this).closest('.input-group').find('.quantity-input');
                var currentValue = parseInt(input.val());
                var maxValue = parseInt(input.attr('max'));
                
                if (action === 'increase' && currentValue < maxValue) {
                    input.val(currentValue + 1);
                } else if (action === 'decrease' && currentValue > 1) {
                    input.val(currentValue - 1);
                }
            });
            
            // Star rating functionality
            $('.rating-star').click(function() {
                var value = $(this).data('value');
                $('#ratingValue').val(value);
                
                // Reset all stars
                $('.rating-star').removeClass('fas').addClass('far');
                
                // Fill stars up to the selected one
                $('.rating-star').each(function() {
                    if ($(this).data('value') <= value) {
                        $(this).removeClass('far').addClass('fas');
                    }
                });
            });
        });
    </script>
</body>
</html>
                                        