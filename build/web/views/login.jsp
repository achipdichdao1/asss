<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Tinh Dầu Thiên Nhiên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="components/header.jsp"></jsp:include>
    
    <!-- Login Section -->
    <section class="login-section py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow">
                        <div class="card-body p-5">
                            <h2 class="text-center mb-4">Đăng Nhập</h2>
                            
                            <!-- Display error message if any -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>
                            
                            <!-- Display success message if any -->
                            <c:if test="${not empty success}">
                                <div class="alert alert-success" role="alert">
                                    ${success}
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/login" method="post">
                                <div class="form-group">
                                    <label for="username">Tên đăng nhập</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        </div>
                                        <input type="text" class="form-control" id="username" name="username" value="${username}" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password">Mật khẩu</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        </div>
                                        <input type="password" class="form-control" id="password" name="password" value="${password}" required>
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary toggle-password" type="button">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="remember" name="remember" ${remember}>
                                        <label class="custom-control-label" for="remember">Ghi nhớ đăng nhập</label>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block py-2">Đăng Nhập</button>
                            </form>
                            
                            <div class="text-center mt-4">
                                <p>Hoặc đăng nhập với:</p>
                                <div class="social-login">
                                    <a href="#" class="btn btn-outline-danger mr-2">
                                        <i class="fab fa-google mr-2"></i> Google
                                    </a>
                                    <a href="#" class="btn btn-outline-primary">
                                        <i class="fab fa-facebook-f mr-2"></i> Facebook
                                    </a>
                                </div>
                            </div>
                            
                            <hr class="my-4">
                            
                            <div class="text-center">
                                <p class="mb-0">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>
                                <p class="mt-2"><a href="#">Quên mật khẩu?</a></p>
                            </div>
                        </div>
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
        $(document).ready(function() {
            // Toggle password visibility
            $('.toggle-password').click(function() {
                var passwordInput = $('#password');
                var icon = $(this).find('i');
                
                if (passwordInput.attr('type') === 'password') {
                    passwordInput.attr('type', 'text');
                    icon.removeClass('fa-eye').addClass('fa-eye-slash');
                } else {
                    passwordInput.attr('type', 'password');
                    icon.removeClass('fa-eye-slash').addClass('fa-eye');
                }
            });
        });
    </script>
</body>
</html>