document.addEventListener('turbo:load', function() {

  // business_descriptionを表示
  document.getElementById('show-description').addEventListener('click', function() {
    const description = document.getElementById('show-description').getAttribute('data-description');
    document.querySelector('.more-description').textContent = description;
  });

  // article_summaryを表示
  document.getElementById('show-summary').addEventListener('click', function() {
    const summary = document.getElementById('show-summary').getAttribute('data-summary');
    document.querySelector('.more-description').textContent = summary;
  });

});
