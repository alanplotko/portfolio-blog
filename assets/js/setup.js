$(document).ready(function() {
  particlesJS.load('particles-js');
  $('.email-btn').click(function() {
    $('p.note').fadeToggle('fast', 'linear');
  });
});
