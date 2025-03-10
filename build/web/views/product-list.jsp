<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm - Tinh Dầu Thiên Nhiên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="components/header.jsp"></jsp:include>
    
    <!-- Products Section -->
    <section class="products-section py-5">
        <div class="container">
            <!-- Title and Search -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <h2>Tất Cả Sản Phẩm</h2>
                </div>
                <div class="col-md-6">
                    <form class="form-inline justify-content-md-end" action="${pageContext.request.contextPath}/products" method="get">
                        <div class="input-group">
                            <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm sản phẩm..." value="${param.keyword}">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Filters -->
            <div class="row mb-4">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/products" method="get" class="row">
                                <div class="col-md-3 mb-2 mb-md-0">
                                    <select class="form-control" name="category">
                                        <option value="">Tất cả danh mục</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.categoryID}" ${param.category == category.categoryID ? 'selected' : ''}>${category.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-2 mb-md-0">
                                    <select class="form-control" name="sort">
                                        <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                                        <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Giá: Thấp đến cao</option>
                                        <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Giá: Cao đến thấp</option>
                                        <option value="name-asc" ${param.sort == 'name-asc' ? 'selected' : ''}>Tên: A-Z</option>
                                        <option value="name-desc" ${param.sort == 'name-desc' ? 'selected' : ''}>Tên: Z-A</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Giá</span>
                                        </div>
                                        <input type="number" class="form-control" name="minPrice" placeholder="Từ" value="${param.minPrice}">
                                        <input type="number" class="form-control" name="maxPrice" placeholder="Đến" value="${param.maxPrice}">
                                    </div>
                                </div>
                                <div class="col-md-2 text-right">
                                    <button type="submit" class="btn btn-primary">Lọc</button>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">Reset</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Products Grid -->
            <div class="row">
                <c:if test="${empty products}">
                    <div class="col-12 text-center py-5">
                        <h4>Không tìm thấy sản phẩm nào.</h4>
                        <p>Vui lòng thử lại với các tiêu chí tìm kiếm khác.</p>
                    </div>
                </c:if>
                
                <c:forEach items="${products}" var="product">
                    <div class="col-md-3 mb-4">
                        <div class="card h-100 product-card">
                                                        <img src="assets/images/products/${product.imageURL}" class="card-img-top" alt="${product.productName}">
                            <div class="card-body">
                                <h5 class="card-title">${product.productName}</h5>
                                <p class="card-text price">${product.price} VNĐ</p>
                                <div class="d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.productID}" class="btn btn-outline-primary">Chi Tiết</a>
                                    <a href="${pageContext.request.contextPath}/cart?action=add&id=${product.productID}" class="btn btn-primary">Thêm Vào Giỏ</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/products?page=${currentPage - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/products?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/products?page=${currentPage + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="components/footer.jsp"></jsp:include>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>