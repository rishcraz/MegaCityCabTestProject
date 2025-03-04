<%@ page contentType="text/html; charset=UTF-8" %>
<%-- Session check for customer --%>
<%
    HttpSession userSession = request.getSession(false);
    String userId = (userSession != null) ? (String) userSession.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - MegaCityCab</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/all_css/customer/about.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<%@ include file="header.jsp" %>


    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
          <h1 class="brand-name">Mega<span class="yellow-text">City</span>Cab</h1>

            <p>Your trusted ride, anytime, anywhere.</p>
        </div>
        <img src="<%= request.getContextPath() %>/component/pictures/car4.jpg" alt="Hero Image" class="hero-img">
    </section>

    <!-- Moving Taxi Animation -->
    <div class="road-container">
        <div class="road"></div>
        <img src="<%= request.getContextPath() %>/component/pictures/car2.png" alt="Taxi Moving" class="taxi">
    </div>

    <!-- About Section -->
    <section class="about-section">
        <h2>Who We Are</h2>
        <p>Founded in 2020, <strong>MegaCityCab</strong> is committed to providing seamless urban travel. Our mission is to offer a safe, reliable, and affordable ride for everyone.</p>
    </section>

    <!-- Why Choose Us? -->
    <section class="card-section">
        <h2>Why Choose Us?</h2>
        <div class="card-container">
            <div class="info-card">
                <i class="fas fa-handshake"></i>
                <h3>Trust</h3>
                <p>Reliable and secure rides with trained drivers.</p>
            </div>
            <div class="info-card">
                <i class="fas fa-lightbulb"></i>
                <h3>Innovation</h3>
                <p>Smart AI-powered route optimization.</p>
            </div>
            <div class="info-card">
                <i class="fas fa-users"></i>
                <h3>Community</h3>
                <p>Dedicated to serving our local neighborhoods.</p>
            </div>
            <div class="info-card">
                <i class="fas fa-city"></i>
                <h3>Cities</h3>
                <p>Operating in multiple major metro areas.</p>
            </div>
            <div class="info-card">
                <i class="fas fa-star"></i>
                <h3>Customer Satisfaction</h3>
                <p>Rated highly by thousands of satisfied riders.</p>
            </div>
        </div>
    </section>

    <!-- Parallax Section -->
    <section class="parallax">
        <div class="parallax-content">
            <h2>Join the Future of Urban Mobility</h2>
            <p>We are redefining convenience with eco-friendly and AI-powered transport.</p>
        </div>
        <img src="<%= request.getContextPath() %>/component/pictures/car5.jpg" alt="City Lights" class="parallax-img">
    </section>

   <%@ include file="footer.jsp" %>
   

</body>
</html>
