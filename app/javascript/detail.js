document.addEventListener('DOMContentLoaded', function() {
  // Hover-trigger behavior
  document.querySelectorAll('.hover-trigger').forEach(function(trigger) {
    trigger.addEventListener('click', function() {
      var targetId = this.getAttribute('data-toggle');
      var targetElement = document.getElementById(targetId);
      if (targetElement.style.display === 'none') {
        targetElement.style.display = 'block';
      } else {
        targetElement.style.display = 'none';
      }
    });
  });

  // More-description hover behavior
  document.querySelectorAll('.more-description-trigger').forEach(function(trigger) {
    trigger.addEventListener('mouseover', function() {
      var targetId = this.getAttribute('data-toggle');
      var targetElement = document.getElementById(targetId);
      targetElement.style.display = 'block';
    });

    trigger.addEventListener('mouseout', function() {
      var targetId = this.getAttribute('data-toggle');
      var targetElement = document.getElementById(targetId);
      targetElement.style.display = 'none';
    });
  });

  // Article-summary click behavior
  document.querySelectorAll('.article-summary-trigger').forEach(function(trigger) {
    trigger.addEventListener('click', function() {
      var targetId = this.getAttribute('data-toggle');
      var targetElement = document.getElementById(targetId);
      if (targetElement.style.display === 'none') {
        targetElement.style.display = 'block';
      } else {
        targetElement.style.display = 'none';
      }
    });
  });
});
