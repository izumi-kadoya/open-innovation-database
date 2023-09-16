document.addEventListener("DOMContentLoaded", function() {

  // ボタンクリック時の処理
  document.querySelector("#description_renew").addEventListener("click", function(event) {
    const record_url = event.target.dataset.url; 
    const prompt = `Describe the business of this startup with the website link of ${record_url}? Please provide a straightforward description without using template-like formats.`;
    access_openai(prompt);
  });

  function setQnA(question, result) {
    document.querySelector('#question').textContent = question;
    document.querySelector('#result').textContent = result;
  }

  function access_openai(prompt) {
    const recordId = document.querySelector("#save_description").getAttribute("record-id");

    fetch(`/records/${recordId}/access_openai_description`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
      },
      body: JSON.stringify({ prompt: prompt })
    })
    .then(response => response.json())
    .then(json_data => {
      if (json_data.error) {
        console.error("API error:", json_data.error);
        alert('An error occurred while fetching the description.');
        return;
      }
      console.log(json_data);  
      const result = json_data.choices[0].text.trim();
      document.querySelector('#more-description').textContent = result;
    });
  }
});

// saveをクリックするとテーブルに上書き保存する
document.querySelector("#save_description").addEventListener("click", function() {
  const newDescription = document.querySelector('#more-description').textContent;

  // ボタンのrecord-id属性からレコードのIDを取得
  const recordId = this.getAttribute("record-id");

  saveDescription(recordId, newDescription);
});

function saveDescription(recordId, description) {
  fetch(`/records/${recordId}/save_business_description`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
    },
    body: JSON.stringify({ business_description: description })
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      alert('Description saved successfully!');
    } else {
      alert('Error saving description.');
    }
  });
}
