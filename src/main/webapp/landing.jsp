<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCityCab - Comfort & Reliability</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/welcome.css">

    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<style>
 body {
            font-family: 'Poppins', sans-serif;
            background: #121212;
            color: #ffffff;
            margin: 0;
            padding: 0;
        }

        /* Navbar */
        .navbar {
            background: #212529;
            padding: 10px 0;
        }

        .navbar-brand {
            font-size: 2rem;
            font-weight: bold;
        }

        .white-text {
            color: #ffffff;
        }

        .yellow-text {
            color: #FFA500;
        }

        .nav-item a {
            color: #ffffff !important;
            font-size: 1rem;
        }

        .nav-item a:hover {
            color: #FFA500 !important;
        }

        /* Hero Section */
        .hero-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-top: 60px;
        }

        .hero-text h1 {
            font-size: 3.5rem;
            font-weight: 700;
            color: #FFA500;
        }

        .hero-text p {
            font-size: 1.1rem;
            color: #cccccc;
        }

        .orange-shape {
            background: #FFA500;
            padding: 40px;
            border-radius: 20px;
            display: inline-block;
            clip-path: polygon(10% 0%, 100% 0%, 100% 100%, 0% 90%);
        }

        .car-image {
            width: 100%;
            max-width: 420px;
        }

        /* Booking Form */
        .booking-section {
            background: #212529;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            margin-top: 60px;
        }

        .form-label {
            font-weight: 600;
            color: #FFA500;
        }

        .btn-custom {
            background: #212529;
            color: #ffffff;
            font-weight: 600;
        }

        .btn-custom:hover {
            background: #FFA500;
            color: #212529;
        }

        .btn-search {
            background: #FFA500;
            color: #212529;
            font-weight: 600;
        }

        .btn-search:hover {
            background: #212529;
            color: #ffffff;
        }
</style>
    
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand">
            <span class="yellow-text"> Welcome <span class="white-text">to</span> </span> <span class="white-text">  | Mega</span><span class="yellow-text">City</span><span class="white-text">Cab</span>
        </a>
        <div class="d-flex align-items-center">
            <span class="me-4"><i class="fas fa-phone-alt"></i> +123 456 7890</span>
            <span class="me-4"><i class="fas fa-envelope"></i> support@megacitycab.com</span>
            <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-outline-light me-2">Sign In</a>
            <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-warning">Sign Up</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="container hero-section text-center text-lg-start">
    <div class="hero-text col-lg-6">
        <h1>Ride in Comfort & Style</h1>
        <p>Get a ride anytime, anywhere. Safe, comfortable, and reliable cab service just a click away.</p>
        <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-custom me-3">Get Started</a>
        <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-outline-dark">
            <i class="fas fa-play-circle me-2"></i> Watch Video
        </a>
    </div>
    <div class="col-lg-6 text-center">
        <div class="orange-shape">
            <img src="<%= request.getContextPath() %>/component/pictures/car7.png" alt="Blue Sports Car" class="car-image">
        </div>
    </div>
</section>

<!-- Booking Form -->
<section class="container booking-section">
    <h3 class="text-center mb-4">Book Your Ride</h3>
    <form class="row g-4" action="<%= request.getContextPath() %>/register.jsp">
        <div class="col-md-3">
            <label for="location" class="form-label">Location</label>
            <input type="text" class="form-control" id="location" placeholder="Choose Location" required>
        </div>
        <div class="col-md-3">
            <label for="carType" class="form-label">Car Type</label>
            <select class="form-select" id="carType" required>
                <option selected>City Car</option>
                <option value="SUV">SUV</option>
                <option value="Sedan">Sedan</option>
            </select>
        </div>
        <div class="col-md-3">
            <label for="pickUp" class="form-label">Pick Up</label>
            <input type="date" class="form-control" id="pickUp" placeholder="mm/dd/yyyy" required>
        </div>
        <div class="col-md-3">
            <label for="return" class="form-label">Return</label>
            <input type="date" class="form-control" id="return" placeholder="mm/dd/yyyy" required>
        </div>
        <div class="col-12 d-flex justify-content-center">
            <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-search px-5">Search Rides</a>
        </div>
    </form>
</section>

<!-- Bootstrap JS Bundle -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<!-- FontAwesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</body>
</html>
