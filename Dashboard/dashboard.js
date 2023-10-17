// Event listeners for buttons
document.getElementById("menu-button").addEventListener("click", toggleSidebar);
document.getElementById("notification-button").addEventListener("click", toggleNotifications);
document.getElementById("profile-button").addEventListener("click", toggleProfile);

// Function to toggle the sidebar
function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    if (sidebar.style.display === "block") {
        hideAll();
        return; // exit the function early
    }
    hideAll(); // Hide all dropdowns first
    toggleElement(sidebar);
}

// Function to toggle the notifications bar
function toggleNotifications() {
    const notifications = document.getElementById("notification-bar");
    if (notifications.style.display === "block") {
        hideAll();
        return; // exit the function early
    }
    hideAll(); // Hide all dropdowns first
    toggleElement(notifications);
}

// Function to toggle the profile bar
function toggleProfile() {
    const profile = document.getElementById("profile-bar");
    if (profile.style.display === "block") {
        hideAll();
        return; // exit the function early
    }
    hideAll(); // Hide all dropdowns first
    toggleElement(profile);
}

// General function to toggle the visibility of an element
function toggleElement(element) {
    if (getComputedStyle(element).display === "none") {
        element.style.display = "block";
    } else {
        element.style.display = "none";
    }
}

// Function to hide all dropdowns
function hideAll() {
    document.getElementById("sidebar").style.display = "none";
    document.getElementById("notification-bar").style.display = "none";
    document.getElementById("profile-bar").style.display = "none";
}

// Close dropdowns when clicking outside
document.addEventListener("click", function (event) {
    if (
        !event.target.closest(".header") &&
        !event.target.closest(".sidebar") &&
        !event.target.closest(".notification-bar") &&
        !event.target.closest(".profile-bar")
    ) {
        hideAll();
    }
});
