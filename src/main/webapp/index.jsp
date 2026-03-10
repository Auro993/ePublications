<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.BookDAO, com.db.DBConnect, com.user.Book, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>E-Books - Digital Library</title>
    <%@include file="all_component/allcss.jsp"%>
    <style>
        .hero-section {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9) 0%, rgba(118, 75, 162, 0.9) 100%), url('img/hero-bg.jpeg') center/cover no-repeat;
            color: white;
            padding: 120px 0;
            text-align: center;
            min-height: 80vh;
            display: flex;
            align-items: center;
        }
        .book-card {
            border: none;
            border-radius: 15px;
            transition: transform 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .book-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }
        .category-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: transform 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            height: 100%;
        }
        .category-card:hover {
            transform: translateY(-5px);
        }
        .feature-card {
            text-align: center;
            padding: 30px 20px;
            border: none;
            border-radius: 15px;
            transition: transform 0.3s ease;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .stats-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
        }
        .stat-number {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .features-section {
            background: url('img/features-bg.jpeg') center/cover no-repeat;
            padding: 80px 0;
            position: relative;
        }
        .features-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.7);
        }
        .features-section .container {
            position: relative;
            z-index: 1;
        }
    </style>
</head>
<body>
    <%@include file="all_component/navbar.jsp"%>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <h1 class="display-3 fw-bold mb-4">DISCOVER YOUR NEXT<br><span class="text-warning">Favorite Book</span></h1>
            <p class="lead mb-4 fs-5">Access thousands of e-books from various genres. Read anytime, anywhere on any device.</p>
            <a href="login.jsp" class="btn btn-warning btn-lg me-3 px-4 py-2 fw-bold">Get Started</a>
            <a href="login.jsp" class="btn btn-outline-light btn-lg px-4 py-2">Explore Books</a>
        </div>
    </section>

    <!-- Featured Books Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-4 fw-bold text-primary mb-3">Featured Books</h2>
                <p class="lead text-muted">Discover our most popular e-books</p>
            </div>

            <div class="row">
                <%
                    BookDAO bookDao = new BookDAO(DBConnect.getConn());
                    List<Book> books = bookDao.getAllBooks();
                    
                    if (books.isEmpty()) {
                %>
                    <div class="col-12 text-center">
                        <div class="alert alert-info">
                            <h5><i class="fas fa-info-circle me-2"></i>No Books Available</h5>
                            <p>Please check back later for new book additions.</p>
                        </div>
                    </div>
                <%
                    } else {
                        String[] sampleImages = {
                            "img/books/book1.jpeg",
                            "img/books/book2.jpeg", 
                            "img/books/book3.jpeg",
                            "img/books/book4.jpeg"
                        };
                        int count = 0;
                        for (Book book : books) {
                            if (count >= 4) break;
                            String bookImage = sampleImages[count % sampleImages.length];
                %>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card book-card h-100">
                        <img src="<%= bookImage %>" class="card-img-top" alt="<%= book.getTitle() %>" 
                             style="height: 300px; object-fit: cover;">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold"><%= book.getTitle() %></h5>
                            <p class="card-text text-muted mb-2"><%= book.getAuthor() %></p>
                            <h4 class="text-success fw-bold mb-3">$<%= book.getPrice() %></h4>
                            <div class="d-grid gap-2">
                                <a href="login.jsp" class="btn btn-primary">Add to Cart</a>
                                <a href="login.jsp" class="btn btn-outline-secondary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                            count++;
                        }
                    }
                %>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-4 fw-bold text-primary mb-3">Browse Categories</h2>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="category-card">
                        <img src="img/categories/fiction.jpeg" class="img-fluid rounded mb-3" 
                             alt="Fiction" style="height: 150px; width: 100%; object-fit: cover;">
                        <h4 class="fw-bold">Fiction</h4>
                        <p class="text-muted">Imaginative stories, novels, and creative writing</p>
                        <h5 class="text-primary fw-bold">1250+ Books</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="category-card">
                        <img src="img/categories/science.jpeg" class="img-fluid rounded mb-3" 
                             alt="Science" style="height: 150px; width: 100%; object-fit: cover;">
                        <h4 class="fw-bold">Science</h4>
                        <p class="text-muted">Scientific discoveries, research, and innovation</p>
                        <h5 class="text-success fw-bold">100+ Books</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="category-card">
                        <img src="img/categories/business.jpeg" class="img-fluid rounded mb-3" 
                             alt="Business" style="height: 150px; width: 100%; object-fit: cover;">
                        <h4 class="fw-bold">Business</h4>
                        <p class="text-muted">Entrepreneurship, management, and success</p>
                        <h5 class="text-warning fw-bold">500+ Books</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="category-card">
                        <img src="img/categories/romance.jpeg" class="img-fluid rounded mb-3" 
                             alt="Romance" style="height: 150px; width: 100%; object-fit: cover;">
                        <h4 class="fw-bold">Romance</h4>
                        <p class="text-muted">Love stories, relationships, and emotional journeys</p>
                        <h5 class="text-danger fw-bold">50+ Books</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Why Choose E-Books Section -->
    <section class="features-section text-white">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-4 fw-bold mb-3">Why Choose E-Books?</h2>
                <p class="lead">Experience the future of reading with our digital platform</p>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="feature-card h-100">
                        <div class="text-primary mb-3">
                            <i class="fas fa-book-open fa-3x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Wide Collection</h5>
                        <p class="text-muted">Thousands of books across all genres and categories</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="feature-card h-100">
                        <div class="text-success mb-3">
                            <i class="fas fa-mobile-alt fa-3x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Read Anywhere</h5>
                        <p class="text-muted">Access your library on any device, anytime, anywhere</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="feature-card h-100">
                        <div class="text-warning mb-3">
                            <i class="fas fa-search fa-3x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Easy Search</h5>
                        <p class="text-muted">Find your favorite books quickly with advanced search</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="feature-card h-100">
                        <div class="text-info mb-3">
                            <i class="fas fa-download fa-3x"></i>
                        </div>
                        <h5 class="fw-bold text-dark">Instant Download</h5>
                        <p class="text-muted">Get your books immediately after purchase</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-number">10,000+</div>
                    <h5>E-Books Available</h5>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-number">50,000+</div>
                    <h5>Happy Readers</h5>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-number">100+</div>
                    <h5>Categories</h5>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-number">24/7</div>
                    <h5>Support Available</h5>
                </div>
            </div>
        </div>
    </section>

    <%@include file="all_component/footer.jsp"%>
</body>
</html>