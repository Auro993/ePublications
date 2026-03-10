<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.user.UserDetails, com.dao.CartDAO, com.dao.BookDAO, com.db.DBConnect, com.user.Book, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cart - E-Books</title>
<%@include file="all_component/allcss.jsp"%>
<style>
.cart-item {border:1px solid #ddd; border-radius:10px; padding:15px; margin-bottom:15px;}
.cart-item img {height:100px; width:100px; object-fit:cover; border-radius:5px;}
.total-box {background:#007bff; color:white; padding:20px; border-radius:10px;}
.book-placeholder {
    width: 100px; 
    height: 100px; 
    background: linear-gradient(45deg, #007bff, #6610f2); 
    color: white; 
    border-radius: 5px;
    display: flex;
    align-items: center;
    justify-content: center;
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

// FIX: Use userId from session instead of user.getId()
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    userId = 1; // Demo user ID
    session.setAttribute("userId", userId);
}

CartDAO cartDao = new CartDAO(DBConnect.getConn());
BookDAO bookDao = new BookDAO(DBConnect.getConn());

// FIX: Use userId from session
List<Integer> cartBookIds = cartDao.getCartBooksByUserId(userId);
List<Book> cartBooks = new ArrayList<>();
double total = 0.0;

for (int id : cartBookIds) {
    Book b = bookDao.getBookById(id);
    if (b != null) {
        cartBooks.add(b);
        total += b.getPrice();
    }
}
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
<h3 class="text-center mb-4">🛒 Your Shopping Cart</h3>

<% if (cartBooks.isEmpty()) { %>
    <div class="alert alert-info text-center py-5">
        <i class="fas fa-shopping-cart fa-3x mb-3"></i>
        <h4>Your cart is empty</h4>
        <p class="text-muted">Browse our collection and add some books to your cart.</p>
        <a href="home.jsp" class="btn btn-primary mt-2">
            <i class="fas fa-book me-2"></i>Browse Books
        </a>
    </div>
<% } else { %>
<div class="row">
    <div class="col-md-8">
        <% for (Book b : cartBooks) { %>
        <div class="cart-item d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center">
                <!-- FIX: Use placeholder image instead of getImagePath() -->
                <div class="book-placeholder">
                    <i class="fas fa-book fa-2x"></i>
                </div>
                <div class="ms-3">
                    <h5><%= b.getTitle() %></h5>
                    <p class="text-muted mb-1"><i class="fas fa-user me-1"></i><%= b.getAuthor() %></p>
                    <p class="mb-1"><span class="badge bg-primary"><%= b.getCategory() %></span></p>
                    <p class="text-success fw-bold mb-0">$<%= b.getPrice() %></p>
                </div>
            </div>
            <a href="RemoveFromCart?bookId=<%= b.getId() %>" 
               class="btn btn-danger btn-sm"
               onclick="return confirm('Remove <%= b.getTitle() %> from cart?')">
                <i class="fas fa-trash me-1"></i> Remove
            </a>
        </div>
        <% } %>
    </div>
    <div class="col-md-4">
        <div class="total-box">
            <h4><i class="fas fa-receipt me-2"></i>Order Summary</h4>
            <hr style="background-color: white;">
            <div class="d-flex justify-content-between mb-2">
                <span>Items:</span>
                <span><%= cartBooks.size() %></span>
            </div>
            <div class="d-flex justify-content-between mb-3">
                <span><strong>Total:</strong></span>
                <span><strong>$<%= String.format("%.2f", total) %></strong></span>
            </div>
            <a href="checkout.jsp" class="btn btn-light w-100 mt-3">
                <i class="fas fa-credit-card me-2"></i>Proceed to Checkout
            </a>
            <a href="ClearCart" class="btn btn-outline-light w-100 mt-2" 
               onclick="return confirm('Clear all items from cart?')">
                <i class="fas fa-broom me-2"></i>Clear Cart
            </a>
            <a href="home.jsp" class="btn btn-outline-light w-100 mt-2">
                <i class="fas fa-arrow-left me-2"></i>Continue Shopping
            </a>
        </div>
    </div>
</div>
<% } %>
</div>

<%@include file="all_component/footer.jsp"%>

<script>
// Auto refresh when item is removed from cart
document.addEventListener('DOMContentLoaded', function() {
    const successAlert = document.querySelector('.alert-success');
    if (successAlert && (successAlert.textContent.includes('removed') || successAlert.textContent.includes('cleared'))) {
        setTimeout(function() {
            window.location.reload();
        }, 1500);
    }
});
</script>
</body>
</html>