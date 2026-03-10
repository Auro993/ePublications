<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.user.UserDetails, com.dao.BookDAO, com.db.DBConnect, com.user.Book, java.util.List, com.dao.CartDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>E-Books - Dashboard</title>
    <%@include file="all_component/allcss.jsp"%>
    <style>
        .book-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #e0e0e0;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .btn-action {
            transition: all 0.3s ease;
        }
        .btn-action:hover {
            transform: scale(1.05);
        }
        .book-placeholder {
            background: linear-gradient(45deg, #007bff, #6610f2);
            color: white;
        }
    </style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>
    
    <%
        UserDetails user = (UserDetails) session.getAttribute("userobj");
        if (user == null) {
            session.setAttribute("Login-error", "Please login first...");
            response.sendRedirect("login.jsp");
            return;
        }
        
        BookDAO bookDao = new BookDAO(DBConnect.getConn());
        List<Book> books = bookDao.getAllBooks();
        
        int cartItemCount = 0;
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            userId = 1;
            session.setAttribute("userId", userId);
        }
        
        CartDAO cartDao = new CartDAO(DBConnect.getConn());
        cartItemCount = cartDao.getCartItemCount(userId);
        session.setAttribute("cartCount", cartItemCount);
    %>
    
    <!-- Success/Error Messages -->
    <div class="container mt-3">
        <%
            String successMsg = (String) session.getAttribute("successMsg");
            String errorMsg = (String) session.getAttribute("errorMsg");
            
            if(successMsg != null) {
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i><%= successMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <%
                session.removeAttribute("successMsg");
            }
            
            if(errorMsg != null) {
        %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i><%= errorMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <%
                session.removeAttribute("errorMsg");
            }
        %>
    </div>

    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="mb-0"><i class="fas fa-tachometer-alt me-2"></i>Dashboard - Welcome, <%= user.getName() %></h4>
                            <div>
                                <a href="cart.jsp" class="btn btn-light btn-sm me-2">
                                    <i class="fas fa-shopping-cart me-1"></i>Cart 
                                    <% if(cartItemCount > 0) { %>
                                        <span class="badge bg-danger"><%= cartItemCount %></span>
                                    <% } %>
                                </a>
                                <a href="logout.jsp" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to logout?');">
                                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- User Info Cards -->
                        <div class="row mb-4">
                            <div class="col-md-4 mb-3">
                                <div class="card text-white bg-success h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h5><i class="fas fa-user me-2"></i>Profile</h5>
                                                <p class="mb-1"><strong>Name:</strong> <%= user.getName() %></p>
                                                <p class="mb-1"><strong>Email:</strong> <%= user.getEmail() %></p>
                                                <p class="mb-0"><strong>Phone:</strong> <%= user.getPhone() != null ? user.getPhone() : "Not provided" %></p>
                                            </div>
                                            <div>
                                                <i class="fas fa-user-circle fa-3x"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card text-white bg-info h-100">
                                    <div class="card-body text-center">
                                        <h5><i class="fas fa-book me-2"></i>Total Books</h5>
                                        <h2 class="display-4"><%= books.size() %></h2>
                                        <p class="mb-0">Available in library</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card text-white bg-warning h-100">
                                    <div class="card-body text-center">
                                        <h5><i class="fas fa-star me-2"></i>Your Status</h5>
                                        <h2 class="display-4">Active</h2>
                                        <p class="mb-0">
                                            <% if(cartItemCount > 0) { %>
                                                You have <%= cartItemCount %> items in cart
                                            <% } else { %>
                                                Premium Reader
                                            <% } %>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Books Section -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4><i class="fas fa-book-open me-2"></i>Available Books</h4>
                                    <div>
                                        <span class="badge bg-primary fs-6 me-2"><%= books.size() %> books</span>
                                        <span class="badge bg-success fs-6"><%= cartItemCount %> in cart</span>
                                    </div>
                                </div>
                                
                                <% if (books.isEmpty()) { %>
                                    <div class="alert alert-info text-center">
                                        <h5><i class="fas fa-info-circle me-2"></i>No Books Available</h5>
                                        <p class="mb-0">Please check back later for new book additions.</p>
                                    </div>
                                <% } else { %>
                                    <div class="row">
                                        <% for (Book book : books) { %>
                                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                                            <div class="card book-card h-100">
                                                <!-- PLACEHOLDER IMAGE - ALWAYS SHOWN -->
                                                <div class="card-img-top book-placeholder d-flex align-items-center justify-content-center" 
                                                     style="height: 250px;">
                                                    <div class="text-center">
                                                        <i class="fas fa-book fa-3x mb-2"></i>
                                                        <br>
                                                        <small><%= book.getTitle() %></small>
                                                    </div>
                                                </div>
                                                
                                                <div class="card-body d-flex flex-column">
                                                    <h5 class="card-title text-truncate" title="<%= book.getTitle() %>">
                                                        <%= book.getTitle() %>
                                                    </h5>
                                                    <p class="card-text text-muted mb-2">
                                                        <i class="fas fa-user me-1"></i><%= book.getAuthor() %>
                                                    </p>
                                                    <p class="card-text small text-muted flex-grow-1">
                                                        <%= book.getDescription() != null && book.getDescription().length() > 80 ? 
                                                            book.getDescription().substring(0, 80) + "..." : 
                                                            (book.getDescription() != null ? book.getDescription() : "No description available") %>
                                                    </p>
                                                    <div class="mt-auto">
                                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                                            <span class="badge bg-primary"><%= book.getCategory() %></span>
                                                            <span class="text-success fw-bold fs-5">$<%= book.getPrice() %></span>
                                                        </div>
                                                        <div class="d-grid gap-2">
                                                            <a href="ViewDetails?bookId=<%= book.getId() %>" 
                                                               class="btn btn-outline-primary btn-sm btn-action">
                                                                <i class="fas fa-eye me-1"></i>View Details
                                                            </a>
                                                            <a href="AddToCart?bookId=<%= book.getId() %>" 
                                                               class="btn btn-primary btn-sm btn-action">
                                                                <i class="fas fa-shopping-cart me-1"></i>Add to Cart
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="all_component/footer.jsp"%>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto refresh when book added to cart
            const successAlert = document.querySelector('.alert-success');
            if (successAlert && successAlert.textContent.includes('added to cart')) {
                setTimeout(function() {
                    window.location.reload();
                }, 1500);
            }
            
            // Add to cart confirmation
            const addToCartLinks = document.querySelectorAll('a[href*="AddToCart"]');
            addToCartLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    const bookTitle = this.closest('.card-body').querySelector('.card-title').textContent;
                    if (!confirm('Add "' + bookTitle.trim() + '" to cart?')) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
</body>
</html>