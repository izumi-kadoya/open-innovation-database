document.addEventListener('turbo:load', function() {

  // business_descriptionを表示
  var showDescriptionElement = document.getElementById('show-description');
  if (showDescriptionElement) {
    showDescriptionElement.addEventListener('click', function() {
      const description = showDescriptionElement.getAttribute('data-description');
      document.querySelector('.more-description').textContent = description;
    });
  }

  // article_summaryを表示
  var showSummaryElement = document.getElementById('show-summary');
  if (showSummaryElement) {
    showSummaryElement.addEventListener('click', function() {
      const summary = showSummaryElement.getAttribute('data-summary');
      document.querySelector('.more-description').textContent = summary;
    });
  }

});
