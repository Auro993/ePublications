<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>E-Books - Register</title>
    <%@include file="all_component/allcss.jsp"%>
    <style>
        body {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('img/auth-bg.jpeg') no-repeat center center/cover;
            min-height: 100vh;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
        }
        .auth-container {
            flex: 1;
            display: flex;
            align-items: center;
            padding: 2rem 0;
        }
        .card-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
        }
        .btn-primary {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #218838 0%, #1ba87e 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }
        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }
        .text-primary {
            color: #28a745 !important;
        }
        .footer-content {
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }
        .footer-section h5 {
            color: #28a745;
            margin-bottom: 1rem;
        }
        .footer-section ul {
            list-style: none;
            padding: 0;
        }
        .footer-section ul li {
            margin-bottom: 0.5rem;
        }
        .footer-section a {
            color: #ddd;
            text-decoration: none;
            transition: color 0.3s;
        }
        .footer-section a:hover {
            color: #28a745;
        }
        .copyright {
            background-color: rgba(0, 0, 0, 0.9);
            color: #aaa;
            padding: 1rem 0;
            text-align: center;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>
    
    <div class="auth-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="card shadow-lg border-0">
                        <div class="card-header text-white text-center py-4">
                            <h4 class="mb-0"><i class="fas fa-user-plus me-2"></i>Create Your Account</h4>
                            <p class="mb-0 mt-2">Join our community of readers</p>
                        </div>

                        <div class="card-body p-5">
                            
                            <!-- ERROR MESSAGE -->
                            <%
                                String regError = (String) session.getAttribute("reg-error");
                                if (regError != null) {
                            %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i><%= regError %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <%
                                session.removeAttribute("reg-error");
                                }
                                
                                String regSuccess = (String) session.getAttribute("reg-success");
                                if (regSuccess != null) {
                            %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i><%= regSuccess %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <%
                                session.removeAttribute("reg-success");
                                }
                            %>

                            <form action="UserServlet" method="post">
                                <div class="mb-4">
                                    <label for="name" class="form-label fw-semibold">Full Name *</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-user text-success"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0" id="name" name="name" 
                                               placeholder="Enter your full name" required>
                                    </div>
                                </div>

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
                                    <label for="phone" class="form-label fw-semibold">Phone Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">
                                            <i class="fas fa-phone text-success"></i>
                                        </span>
                                        <input type="tel" class="form-control border-start-0" id="phone" name="phone" 
                                               placeholder="Enter your phone number">
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
                                    <button type="submit" class="btn btn-primary btn-lg py-3">
                                        <i class="fas fa-user-plus me-2"></i>Register
                                    </button>
                                </div>
                            </form>

                            <div class="text-center mt-4">
                                <p class="mb-0">Already have an account?
                                    <a href="login.jsp" class="text-success text-decoration-none fw-semibold">
                                        Login here
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer Content -->
    <div class="footer-content">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="footer-section">
                        <h5>E-Books</h5>
                        <p>Your one-stop destination for digital books. Read anytime, anywhere.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="footer-section">
                        <h5>Quick Links</h5>
                        <ul>
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="books.jsp">Books</a></li>
                            <li><a href="about.jsp">About Us</a></li>
                            <li><a href="contact.jsp">Contact</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="footer-section">
                        <h5>Contact Info</h5>
                        <ul>
                            <li><i class="fas fa-envelope me-2"></i>info@ebooks.com</li>
                            <li><i class="fas fa-phone me-2"></i>+1 234 567 8900</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="copyright">
        <div class="container">
            <p class="mb-0">&copy; 2024 E-Books. All rights reserved.</p>
        </div>
    </div>
</body>
</html>