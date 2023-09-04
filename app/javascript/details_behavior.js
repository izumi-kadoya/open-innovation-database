document.addEventListener("DOMContentLoaded", function() {
  let hoverTriggers = document.querySelectorAll(".hover-trigger-description");
  hoverTriggers.forEach(trigger => {
      trigger.addEventListener("mouseover", function() {
          let targetId = this.getAttribute("data-toggle");
          document.getElementById(targetId).style.display = "block";
      });
      trigger.addEventListener("mouseout", function() {
          let targetId = this.getAttribute("data-toggle");
          document.getElementById(targetId).style.display = "none";
      });
  });

  let clickTriggers = document.querySelectorAll(".click-trigger-summary");
  clickTriggers.forEach(trigger => {
      trigger.addEventListener("click", function() {
          let targetId = this.getAttribute("data-toggle");
          let targetElement = document.getElementById(targetId);
          targetElement.style.display = (targetElement.style.display == "none") ? "block" : "none";
      });
  });
});
