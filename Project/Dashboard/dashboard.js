// Function to toggle the display of a dropdown menu
function toggleDropdown(buttonId) {
    var dropdown = document.getElementById(buttonId + '-dropdown');
    if (dropdown.style.display === 'block') {
        dropdown.style.display = 'none';
    } else {
        dropdown.style.display = 'block';
    }
}

// Event listener for the profile button
document.getElementById('profile-button').addEventListener('click', function () {
    toggleDropdown('profile');
});

// Event listener for the settings button
document.getElementById('settings-button').addEventListener('click', function () {
    toggleDropdown('settings');
});

// Close the dropdown when clicking outside
window.addEventListener('click', function (event) {
    var dropdowns = document.querySelectorAll('.dropdown');
    for (var i = 0; i < dropdowns.length; i++) {
        var dropdown = dropdowns[i];
        if (event.target !== dropdown.previousElementSibling && !dropdown.contains(event.target)) {
            dropdown.style.display = 'none';
        }
    }
});

// Handle select change for profile dropdown
document.getElementById('profile-dropdown').addEventListener('change', function () {
  var selectedOption = this.value;
  // Handle the selected option as needed, e.g., redirect to a page
  if (selectedOption === 'Account') {
      // Redirect to My Account page
      window.location.href = 'myaccount.html';
  } else if (selectedOption === 'Notifications') {
      // Redirect to Notifications page
      window.location.href = 'notifications.html';
  } else if (selectedOption === 'EHR') {
      // Redirect to Back to EHR page
      window.location.href = 'ehr.html';
  } else if (selectedOption === 'LogOut') {
      // Handle log out logic, e.g., clearing session
      // Then redirect to the logout page
      window.location.href = 'logout.html';
  }
});