import { $ } from './bling';

function checkSignup(event) {
  if ($('[name="username"]').value === '') {
    event.preventDefault();
    $('.username_error').classList.add('visible');
  } else {
    $('.username_error').classList.remove('visible');
  }
  if ($('[name="email"]').value === '') {
    event.preventDefault();
    $('.email_error').classList.add('visible');
  } else {
    $('.email_error').classList.remove('visible');
  }
  if ($('[name="password"]').value === '') {
    event.preventDefault();
    $('.password_error').classList.add('visible');
  } else {
    $('.password_error').classList.remove('visible');
  }
}

$('#account_signup').addEventListener('submit', checkSignup);
