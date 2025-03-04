document.addEventListener("DOMContentLoaded", function () {
    const taxi = document.querySelector(".taxi");

    // Click animation effect
    taxi.addEventListener("click", function () {
        taxi.style.animation = "moveTaxi 2s ease-in-out";
        setTimeout(() => {
            taxi.style.animation = "moveTaxi 4s ease-in-out infinite";
        }, 2000);
    });

    // Floating card animation
    document.querySelectorAll(".info-card").forEach(card => {
        card.addEventListener("mouseover", () => {
            card.style.transform = "translateY(-10px)";
        });
        card.addEventListener("mouseleave", () => {
            card.style.transform = "translateY(0)";
        });
    });

    // Scroll Reveal Animations
    ScrollReveal().reveal('.about-section h2, .card-section h2', { delay: 200, origin: 'bottom', distance: '50px', duration: 1000 });
    ScrollReveal().reveal('.info-card', { interval: 200, origin: 'bottom', distance: '30px', duration: 1000 });
});
