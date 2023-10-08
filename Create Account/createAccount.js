// JavaScript for basic form validation on the registration page
document.addEventListener('DOMContentLoaded', function() {
  const form = document.querySelector('form');
  const firstNameInput = document.getElementById('firstName');
  const lastNameInput = document.getElementById('lastName');
  const usernameInput = document.getElementById('username');
  const emailInput = document.getElementById('email');
  const phoneInput = document.getElementById('phone');
  const passwordInput = document.getElementById('password');

  form.addEventListener('submit', function(event) {
      event.preventDefault();

      // Basic validation (you can add more complex validation as needed)
      if (isEmpty(firstNameInput) || isEmpty(lastNameInput) || isEmpty(usernameInput) ||
          isEmpty(emailInput) || isEmpty(phoneInput) || isEmpty(passwordInput)) {
          alert('Please fill in all fields.');
      } else {
          alert('Account created successfully!'); // Replace with actual registration logic
          form.reset(); // Clear the form after successful registration

          //redirect to the login page
          window.location.href='/Login/login.html';
      }
  });

  function isEmpty(input) {
      return input.value.trim() === '';
  }
});