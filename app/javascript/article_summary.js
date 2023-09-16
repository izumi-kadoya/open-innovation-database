document.addEventListener("DOMContentLoaded", function() {

  // 記事の要約を再取得する
  document.querySelector("#article_summary_renew").addEventListener("click", function(event) {
    const article_summary = event.target.dataset.article_summary;
    const prompt = `Summarize the article that includes this line:${article_summary}`;
    access_openai_for_summary(prompt);
  });

  function access_openai_for_summary(prompt) {
    fetch("/records/access_openai_summary", {
      method: "POST",
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({ article_summary: prompt })
    })
    .then(response => response.json())
    .then(json_data => {
      const result = json_data.choices[0].text.trim();
      document.querySelector('#more-description').textContent = result;
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }

  // 取得した要約を保存する
  document.querySelector("#save_article_summary").addEventListener("click", function() {
    const newSummary = document.querySelector('#more-description').textContent;
    const recordId = this.getAttribute("record-id");
    saveSummary(recordId, newSummary);
  });

  function saveSummary(recordId, summary) {
    fetch(`/records/${recordId}/save_article_summary`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({ article_summary: summary })
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        alert('Article summary saved successfully!');
      } else {
        alert('Error saving article summary.');
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
});
