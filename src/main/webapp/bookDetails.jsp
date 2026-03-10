<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.user.Book" %>
<%@ include file="all_component/allcss.jsp" %>
<%@ include file="all_component/navbar.jsp" %>

<%
    Book book = (Book) session.getAttribute("bookDetails");
    if (book == null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= book.getTitle() %> - Book Details</title>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .book-details-container {
            max-width: 900px;
            margin: 50px auto;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .book-img {
            width: 200px;
            height: 260px;
            object-fit: cover;
            border-radius: 10px;
        }
        .book-info h2 {
            font-weight: bold;
        }
        .book-meta p {
            margin-bottom: 8px;
            font-size: 16px;
        }
        .btn-custom {
            border-radius: 25px;
            font-weight: 500;
        }
    </style>
</head>

<body>

<div class="container book-details-container">
    <div class="row align-items-center">
        <div class="col-md-4 text-center">
            <img src="<%= book.getImagePath() != null ? book.getImagePath() : "images/default-book.jpg" %>" 
                 alt="<%= book.getTitle() %>" 
                 class="book-img shadow-sm">
        </div>
        <div class="col-md-8 book-info">
            <h2 class="mb-3"><%= book.getTitle() %></h2>
            <div class="book-meta">
                <p><strong>Author:</strong> <%= book.getAuthor() %></p>
                <p><strong>Category:</strong> <%= book.getCategory() %></p>
                <p><strong>Price:</strong> <span class="text-success fw-bold">$<%= book.getPrice() %></span></p>
                <p><strong>Description:</strong><br><%= book.getDescription() %></p>
            </div>
            
            <div class="mt-4">
                <a href="AddToCart?bookId=<%= book.getId() %>" class="btn btn-primary btn-custom me-2">
                    <i class="fas fa-cart-plus"></i> Add to Cart
                </a>
                <a href="home.jsp" class="btn btn-secondary btn-custom">
                    <i class="fas fa-arrow-left"></i> Back to Home
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="all_component/footer.jsp" %>
</body>
</html>
