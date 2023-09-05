document.addEventListener('DOMContentLoaded', function() {

    // business_descriptionを表示
    document.getElementById('show-description').addEventListener('click', function() {
      const description = '<%= @record.business_description %>'; 
      document.querySelector('.more-description').textContent = description;
    });
  
    // article_summaryを表示
    document.getElementById('show-summary').addEventListener('click', function() {
      const summary = '<%= @record.article_summary %>'; 
      document.querySelector('.more-description').textContent = summary;
    });
  
  });
  