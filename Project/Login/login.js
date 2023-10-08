// JavaScript for login form validation
document.addEventListener('DOMContentLoaded', function() {
  const form = document.querySelector('form');
  const usernameInput = document.getElementById('username');
  const passwordInput = document.getElementById('password');

  form.addEventListener('submit', function(event) {
      event.preventDefault();

      const username = usernameInput.value;
      const password = passwordInput.value;

      if (username === 'ddeysel' && password === 'Devoux4009') {
          alert('Login successful!');
      } else {
          alert('Invalid username or password. Please try again.');
      }
  });
});