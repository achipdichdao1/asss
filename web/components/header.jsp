<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header>
    <!-- Top Bar -->
    <div class="top-bar py-2 bg-dark text-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <ul class="list-inline mb-0">
                        <li class="list-inline-item mr-3">
                            <i class="fas fa-phone-alt mr-1"></i> <a href="tel:1900123456" class="text-light">1900 123 456</a>
                        </li>
                        <li class="list-inline-item">
                            <i class="fas fa-envelope mr-1"></i> <a href="mailto:info@tinhdauthiennhien.com" class="text-light">info@tinhdauthiennhien.com</a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-6 text-md-right">
                    <ul class="list-inline mb-0">
                        <li class="list-inline-item mr-3">
                            <a href="#" class="text-light"><i class="fas fa-shipping-fast mr-1"></i> Kiểm tra đơn hàng</a>
                        </li>
                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <li class="list-inline-item mr-3">
                                    <a href="${pageContext.request.contextPath}/login" class="text-light"><i class="fas fa-user mr-1"></i> Đăng nhập</a>
                                </li>
                                <li class="list-inline-item">
                                    <a href="${pageContext.request.contextPath}/register" class="text-light"><i class="fas fa-user-plus mr-1"></i> Đăng ký</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="list-inline-item mr-3">
                                    <a href="${pageContext.request.contextPath}/account" class="text-light"><i class="fas fa-user mr-1"></i> Xin chào, ${sessionScope.user.fullName}</a>
                                </li>
                                <li class="list-inline-item">
                                    <a href="${pageContext.request.contextPath}/logout" class="text-light"><i class="fas fa-sign-out-alt mr-1"></i> Đăng xuất</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Main Header -->
    <div class="main-header py-3">
        <div class="container">
            <div class="row align-items-center">
                <!-- Logo -->
                <div class="col-md-3 text-center text-md-left mb-3 mb-md-0">
                    <a href="${pageContext.request.contextPath}/home" class="logo">
                        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Tinh Dầu Thiên Nhiên" height="60">
                    </a>
                </div>
                
                <!-- Search Bar -->
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/products" method="get">
                        <div class="input-group">
                            <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm sản phẩm..." aria-label="Tìm kiếm sản phẩm...">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                
                <!-- Cart & Wishlist -->
                <div class="col-md-3 text-center text-md-right">
                    <div class="header-buttons">
                                                <a href="${pageContext.request.contextPath}/wishlist" class="btn btn-outline-primary mr-2">
                            <i class="fas fa-heart"></i>
                            <span class="badge badge-danger">0</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-primary">
                            <i class="fas fa-shopping-cart"></i>
                            <span class="badge badge-danger">${empty cart ? 0 : cart.totalQuantity}</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Navigation Menu -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarMain">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item ${pageContext.request.servletPath eq '/views/home.jsp' ? 'active' : ''}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle ${pageContext.request.servletPath eq '/views/product-list.jsp' ? 'active' : ''}" href="#" id="navbarDropdownProducts" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Sản phẩm
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownProducts">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=1">Tinh dầu hoa</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=2">Tinh dầu trái cây</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=3">Tinh dầu thảo mộc</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=4">Tinh dầu gỗ</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/products">Tất cả sản phẩm</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownDevices" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Máy khuếch tán
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownDevices">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=5">Máy siêu âm</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=6">Máy phun sương</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/products?category=7">Đèn khuếch tán</a>
                        </div>
                    </li>
                    <li class="nav-item ${pageContext.request.servletPath eq '/views/blog.jsp' ? 'active' : ''}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/blog">Blog</a>
                    </li>
                    <li class="nav-item ${pageContext.request.servletPath eq '/views/about.jsp' ? 'active' : ''}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about">Giới thiệu</a>
                    </li>
                    <li class="nav-item ${pageContext.request.servletPath eq '/views/contact.jsp' ? 'active' : ''}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                    </li>
                </ul>
                
                <!-- Admin link if user has admin rights -->
                <c:if test="${not empty sessionScope.user && (sessionScope.user.role eq 'ADMIN' || sessionScope.user.role eq 'MANAGER')}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-light ml-2">
                        <i class="fas fa-user-cog mr-1"></i> Quản trị
                    </a>
                </c:if>
            </div>
        </div>
    </nav>
</header>