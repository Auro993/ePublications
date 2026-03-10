<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>E-Books - Login</title>
    <%@include file="all_component/allcss.jsp"%>
</head>

<body style="background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('img/auth-bg.jpeg') no-repeat center center/cover; min-height: 100vh; background-attachment: fixed;">
    
    <%@include file="all_component/navbar.jsp"%>
    
    <div class="container mt-5 pt-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-success text-white text-center py-4">
                        <h4 class="mb-0"><i class="fas fa-sign-in-alt me-2"></i>Login to Your Account</h4>
                        <p class="mb-0 mt-2">Access your personalized library</p>
                    </div>

                    <div class="card-body p-5">
                        
                        <!-- SUCCESS MESSAGE -->
                        <%
                            String regMsg = (String) session.getAttribute("reg-success");
                            if (regMsg != null) {
                        %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i><%= regMsg %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <%
                            session.removeAttribute("reg-success");
                            }
                        %>
                        
                        <!-- LOGIN FAILED MESSAGE -->
                        <%
                            String failedMsg = (String) session.getAttribute("login-failed");
                            if (failedMsg != null) {
                        %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i><%= failedMsg %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <%
                            session.removeAttribute("login-failed");
                            }
                        %>

                        <form action="LoginServlet" method="post">
                            <div class="mb-4">
                                <label for="email" class="form-label fw-semibold">Email Address *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fas fa-envelope text-success"></i>
                                    </span>
                                    <input type="email" class="form-control border-start-0" id="email" name="email"
                                           placeholder="Enter your email" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="password" class="form-label fw-semibold">Password *</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fas fa-lock text-success"></i>
                                    </span>
                                    <input type="password" class="form-control border-start-0" id="password" 
                                           name="password" placeholder="Enter password" required>
                                </div>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-success btn-lg py-3">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </button>
                            </div>
                        </form>

                        <div class="text-center mt-4">
                            <p class="mb-0">Don't have an account?
                                <a href="register.jsp" class="text-success text-decoration-none fw-semibold">
                                    Create here
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>
