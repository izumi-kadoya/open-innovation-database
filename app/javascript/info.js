document.addEventListener("turbo:load", function() {
  const hoverTriggers = document.querySelectorAll('.hover-trigger');

  hoverTriggers.forEach(trigger => {
    trigger.addEventListener('mouseenter', function() {
      const targetId = this.getAttribute('data-toggle');
      const targetElement = document.getElementById(targetId);
      if (targetElement) {
        targetElement.style.display = 'block';
      }
    });

    trigger.addEventListener('mouseleave', function() {
      const targetId = this.getAttribute('data-toggle');
      const targetElement = document.getElementById(targetId);
      if (targetElement) {
        targetElement.style.display = 'none';
      }
    });
  });
});
