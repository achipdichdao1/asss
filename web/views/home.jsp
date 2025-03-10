<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tinh Dầu Thiên Nhiên - Trang Chủ</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="components/header.jsp"></jsp:include>
    
    <!-- Main Content -->
    <main>
        <!-- Hero Section with Carousel -->
        <section class="hero">
            <div id="heroCarousel" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#heroCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#heroCarousel" data-slide-to="1"></li>
                    <li data-target="#heroCarousel" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/assets/images/banner1.jpg" class="d-block w-100" alt="Tinh dầu thiên nhiên">
                        <div class="carousel-caption d-none d-md-block">
                            <h1>Tinh Dầu Thiên Nhiên</h1>
                            <p>Trải nghiệm sự tinh khiết từ thiên nhiên với bộ sưu tập tinh dầu cao cấp.</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3">Khám phá ngay</a>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/assets/images/banner2.jpg" class="d-block w-100" alt="Máy khuếch tán tinh dầu">
                        <div class="carousel-caption d-none d-md-block">
                            <h1>Máy Khuếch Tán Tinh Dầu</h1>
                            <p>Lan tỏa hương thơm tinh tế trong không gian sống của bạn.</p>
                            <a href="${pageContext.request.contextPath}/products?category=5" class="btn btn-primary mt-3">Xem sản phẩm</a>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/assets/images/banner3.jpg" class="d-block w-100" alt="Bộ quà tặng tinh dầu">
                        <div class="carousel-caption d-none d-md-block">
                            <h1>Bộ Quà Tặng Cao Cấp</h1>
                            <p>Món quà ý nghĩa cho sức khỏe và tinh thần.</p>
                            <a href="${pageContext.request.contextPath}/products?category=8" class="btn btn-primary mt-3">Mua ngay</a>
                        </div>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#heroCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#heroCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </section>
        
        <!-- Featured Categories -->
        <section class="featured-categories py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-4">Danh Mục Sản Phẩm</h2>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <a href="${pageContext.request.contextPath}/products?category=1" class="category-card d-block">
                            <div class="card text-center h-100">
                                <img src="${pageContext.request.contextPath}/assets/images/categories/essential-oils.jpg" class="card-img-top" alt="Tinh dầu nguyên chất">
                                <div class="card-body">
                                    <h5 class="card-title">Tinh Dầu Nguyên Chất</h5>
                                    <p class="card-text">Tinh dầu thiên nhiên 100%, không pha trộn</p>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4 mb-4">
                        <a href="${pageContext.request.contextPath}/products?category=5" class="category-card d-block">
                            <div class="card text-center h-100">
                                <img src="${pageContext.request.contextPath}/assets/images/categories/diffusers.jpg" class="card-img-top" alt="Máy khuếch tán">
                                <div class="card-body">
                                    <h5 class="card-title">Máy Khuếch Tán</h5>
                                    <p class="card-text">Thiết bị khuếch tán tinh dầu hiện đại</p>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4 mb-4">
                        <a href="${pageContext.request.contextPath}/products?category=8" class="category-card d-block">
                            <div class="card text-center h-100">
                                <img src="${pageContext.request.contextPath}/assets/images/categories/gift-sets.jpg" class="card-img-top" alt="Bộ quà tặng">
                                <div class="card-body">
                                    <h5 class="card-title">Bộ Quà Tặng</h5>
                                    <p class="card-text">Quà tặng tinh dầu cao cấp</p>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Featured Products -->
        <section class="featured-products py-5">
            <div class="container">
                <h2 class="text-center mb-4">Sản Phẩm Nổi Bật</h2>
                <div class="row">
                    <c:forEach begin="1" end="8">
                        <div class="col-md-3 mb-4">
                            <div class="product-card card h-100">
                                <div class="badge bg-danger text-white position-absolute" style="top: 10px; right: 10px">Sale</div>
                                <img src="${pageContext.request.contextPath}/assets/images/products/product-${pageScope.count}.jpg" class="card-img-top" alt="Tinh dầu">
                                <div class="card-body">
                                    <h5 class="card-title">Tinh Dầu Oải Hương ${pageScope.count}</h5>
                                    <div class="d-flex justify-content-between mb-2">
                                        <div class="price">
                                            <span class="text-muted text-decoration-line-through">350.000đ</span>
                                            <span class="text-primary ml-1">320.000đ</span>
                                        </div>
                                        <div class="rating">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star-half-alt"></i>
                                        </div>
                                                                        </div>
                                    <p class="card-text">Tinh dầu oải hương Lavender nguyên chất 100% từ Pháp, giúp thư giãn và cải thiện giấc ngủ.</p>
                                </div>
                                <div class="card-footer bg-transparent d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/product?id=${pageScope.count}" class="btn btn-sm btn-outline-primary">Chi tiết</a>
                                    <a href="${pageContext.request.contextPath}/cart?action=add&id=${pageScope.count}" class="btn btn-sm btn-primary">Thêm vào giỏ</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary">Xem tất cả sản phẩm</a>
                </div>
            </div>
        </section>
        
        <!-- Benefits -->
        <section class="benefits py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-5">Lợi Ích Của Tinh Dầu</h2>
                <div class="row">
                    <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                        <div class="card border-0 bg-white text-center h-100 p-4">
                            <div class="mb-3">
                                <i class="fas fa-brain fa-3x text-primary"></i>
                            </div>
                            <h5 class="mb-3">Cải Thiện Tinh Thần</h5>
                            <p>Giúp giảm căng thẳng, lo âu và cải thiện tâm trạng.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                        <div class="card border-0 bg-white text-center h-100 p-4">
                            <div class="mb-3">
                                <i class="fas fa-bed fa-3x text-primary"></i>
                            </div>
                            <h5 class="mb-3">Cải Thiện Giấc Ngủ</h5>
                            <p>Tạo môi trường thư giãn, giúp dễ dàng đi vào giấc ngủ sâu.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                        <div class="card border-0 bg-white text-center h-100 p-4">
                            <div class="mb-3">
                                <i class="fas fa-lungs fa-3x text-primary"></i>
                            </div>
                            <h5 class="mb-3">Hỗ Trợ Hô Hấp</h5>
                            <p>Giúp thông mũi, sạch phổi và dễ thở hơn.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                        <div class="card border-0 bg-white text-center h-100 p-4">
                            <div class="mb-3">
                                <i class="fas fa-shield-virus fa-3x text-primary"></i>
                            </div>
                            <h5 class="mb-3">Tăng Cường Miễn Dịch</h5>
                            <p>Kháng khuẩn, kháng viêm và tăng sức đề kháng tự nhiên.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- How to Use -->
        <section class="how-to-use py-5">
            <div class="container">
                <h2 class="text-center mb-5">Cách Sử Dụng Tinh Dầu</h2>
                <div class="row align-items-center">
                    <div class="col-lg-6 mb-4 mb-lg-0">
                        <img src="${pageContext.request.contextPath}/assets/images/how-to-use.jpg" alt="Cách sử dụng tinh dầu" class="img-fluid rounded">
                    </div>
                    
                    <div class="col-lg-6">
                        <div class="mb-4">
                            <h5><i class="fas fa-diffuser fa-fw text-primary mr-2"></i> Khuếch tán trong không khí</h5>
                            <p>Sử dụng máy khuếch tán để lan tỏa hương thơm và công dụng của tinh dầu trong không gian sống.</p>
                        </div>
                        <div class="mb-4">
                            <h5><i class="fas fa-hands fa-fw text-primary mr-2"></i> Massage trực tiếp</h5>
                            <p>Pha loãng với dầu nền và massage lên vùng da cần điều trị hoặc thư giãn.</p>
                        </div>
                        <div class="mb-4">
                            <h5><i class="fas fa-bath fa-fw text-primary mr-2"></i> Thêm vào nước tắm</h5>
                            <p>Nhỏ vài giọt tinh dầu vào nước tắm để tận hưởng không gian thư giãn và trị liệu.</p>
                        </div>
                        <div>
                            <h5><i class="fas fa-spray-can fa-fw text-primary mr-2"></i> Xịt phòng</h5>
                            <p>Pha tinh dầu với nước và đựng trong bình xịt để làm thơm và khử trùng không gian.</p>
                        </div>
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/blog/how-to-use-essential-oils" class="btn btn-outline-primary">Tìm hiểu thêm</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Testimonials -->
        <section class="testimonials py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-5">Khách Hàng Nói Gì?</h2>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <div class="rating mb-3">
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                </div>
                                <p class="card-text">"Tinh dầu oải hương của shop thực sự tuyệt vời. Mùi hương rất tự nhiên và giúp tôi thư giãn sau ngày làm việc căng thẳng. Chắc chắn sẽ mua lại!"</p>
                                <div class="d-flex align-items-center mt-3">
                                    <img src="${pageContext.request.contextPath}/assets/images/testimonials/user1.jpg" alt="Customer" class="rounded-circle mr-3" width="50" height="50">
                                    <div>
                                        <h6 class="mb-0">Nguyễn Thị Mai</h6>
                                        <small class="text-muted">Hà Nội</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <div class="rating mb-3">
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                </div>
                                <p class="card-text">"Máy khuếch tán tinh dầu của shop thiết kế rất đẹp và hoạt động êm ái. Tôi đã mua 3 cái để đặt ở các phòng khác nhau trong nhà. Rất hài lòng!"</p>
                                <div class="d-flex align-items-center mt-3">
                                    <img src="${pageContext.request.contextPath}/assets/images/testimonials/user2.jpg" alt="Customer" class="rounded-circle mr-3" width="50" height="50">
                                    <div>
                                        <h6 class="mb-0">Trần Văn Minh</h6>
                                        <small class="text-muted">TP. Hồ Chí Minh</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <div class="rating mb-3">
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star text-warning"></i>
                                    <i class="fas fa-star-half-alt text-warning"></i>
                                </div>
                                <p class="card-text">"Bộ quà tặng tinh dầu là món quà hoàn hảo cho sinh nhật mẹ tôi. Đóng gói rất đẹp và chuyên nghiệp. Mẹ tôi rất thích và đã sử dụng hàng ngày."</p>
                                <div class="d-flex align-items-center mt-3">
                                    <img src="${pageContext.request.contextPath}/assets/images/testimonials/user3.jpg" alt="Customer" class="rounded-circle mr-3" width="50" height="50">
                                    <div>
                                        <h6 class="mb-0">Lê Thị Hương</h6>
                                        <small class="text-muted">Đà Nẵng</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Subscribe -->
        <section class="subscribe py-5 text-white">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 text-center">
                        <h3 class="mb-4">Đăng ký nhận tin</h3>
                        <p class="mb-4">Nhận thông tin về sản phẩm mới, khuyến mãi đặc biệt và mẹo sử dụng tinh dầu qua email.</p>
                        <form class="form-inline justify-content-center">
                            <div class="input-group mb-3 w-100">
                                <input type="email" class="form-control" placeholder="Nhập địa chỉ email của bạn">
                                <div class="input-group-append">
                                    <button class="btn btn-light" type="submit">Đăng ký</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp"></jsp:include>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>