<%-- navbar.jsp --%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold fs-3" href="index.jsp">
            <i class="fas fa-book me-2"></i>E-Books
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#featured">Featured Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#categories">Categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#features">Features</a>
                </li>
            </ul>
            <div class="navbar-nav">
                <a class="nav-link btn btn-outline-light me-2" href="login.jsp">Login</a>
                <a class="nav-link btn btn-primary" href="register.jsp">Register</a>
            </div>
        </div>
    </div>
</nav>

<style>
    .navbar {
        padding: 15px 0;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .navbar-brand {
        font-size: 1.8rem !important;
    }
    .nav-link {
        font-weight: 500;
        margin: 0 10px;
    }
    .btn-outline-light {
        border-color: rgba(255,255,255,0.5);
        color: rgba(255,255,255,0.9);
    }
    .btn-outline-light:hover {
        background-color: rgba(255,255,255,0.1);
        color: white;
    }
</style>