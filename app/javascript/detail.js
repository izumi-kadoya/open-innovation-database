document.addEventListener('turbo:load', function() {
  
  // business_descriptionを表示
  var showDescriptionElement = document.getElementById('show-description');
  if (showDescriptionElement) {
    showDescriptionElement.addEventListener('click', function() {
      const description = showDescriptionElement.getAttribute('data-description');
      document.querySelector('.more-description').textContent = description;

      // business_descriptionをネイビーにする
      showDescriptionElement.classList.add('text-navy');

      // article_summaryのネイビーを解除
      if (showSummaryElement) {
        showSummaryElement.classList.remove('text-navy');
      }
    });
  }

  // article_summaryを表示
  var showSummaryElement = document.getElementById('show-summary');
  if (showSummaryElement) {
    showSummaryElement.addEventListener('click', function() {
      const summary = showSummaryElement.getAttribute('data-summary');
      document.querySelector('.more-description').textContent = summary;

      // article_summaryをネイビーにする
      showSummaryElement.classList.add('text-navy');

      // business_descriptionのネイビーを解除
      if (showDescriptionElement) {
        showDescriptionElement.classList.remove('text-navy');
      }
    });
  }

});
