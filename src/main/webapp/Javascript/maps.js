document.addEventListener("DOMContentLoaded", function () {
    const map = L.map('map').setView([6.9271, 79.8612], 12); // Colombo, Sri Lanka

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    let pickupMarker, destinationMarker;
    let pickupCoords, destinationCoords;
    let selectingPickup = true;

    console.log("Maps.js Loaded Successfully!"); // Debugging

    function reverseGeocode(lat, lon, callback) {
        const url = `https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${lat}&lon=${lon}&accept-language=en`;

        fetch(url, {
            headers: {
                "User-Agent": "MegaCityCabApp/1.0 (your-email@example.com)"
            }
        })
        .then(response => response.json())
        .then(data => {
            console.log("Reverse Geocode Response:", data);
            const address = data.display_name || `${lat}, ${lon}`;
            callback(address, lat, lon);
        })
        .catch(error => {
            console.error("Reverse Geocode Error:", error);
            callback(`${lat}, ${lon}`, lat, lon);
        });
    }

    function calculateDistance(lat1, lon1, lat2, lon2) {
        const R = 6371; // Radius of Earth in km
        const dLat = (lat2 - lat1) * Math.PI / 180;
        const dLon = (lon2 - lon1) * Math.PI / 180;
        const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                  Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                  Math.sin(dLon / 2) * Math.sin(dLon / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return (R * c).toFixed(2); // Return distance in km
    }

    map.on('click', function (e) {
        const { lat, lng } = e.latlng;

        reverseGeocode(lat, lng, function (address, latitude, longitude) {
            if (selectingPickup) {
                if (pickupMarker) map.removeLayer(pickupMarker);
                pickupMarker = L.marker([latitude, longitude]).addTo(map)
                    .bindPopup(`Pickup: ${address}`).openPopup();
                document.getElementById("pickupLocation").value = address;
                pickupCoords = { lat: latitude, lon: longitude };
                selectingPickup = false;
                alert("Now click on the map to select your Destination.");
            } else {
                if (destinationMarker) map.removeLayer(destinationMarker);
                destinationMarker = L.marker([latitude, longitude]).addTo(map)
                    .bindPopup(`Destination: ${address}`).openPopup();
                document.getElementById("destination").value = address;
                destinationCoords = { lat: latitude, lon: longitude };
                selectingPickup = true;

                if (pickupCoords && destinationCoords) {
                    const distance = calculateDistance(
                        pickupCoords.lat, pickupCoords.lon,
                        destinationCoords.lat, destinationCoords.lon
                    );
                    document.getElementById("distance").value = distance; // Only numeric value
                }
            }
        });
    });
});
