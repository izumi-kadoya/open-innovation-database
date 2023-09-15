
document.addEventListener("DOMContentLoaded", function() {
  const api_key = window.apiKey; 

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
    fetch("https://api.openai.com/v1/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + api_key 
      },
      body: JSON.stringify({
        "model": "text-davinci-003",
        "prompt":prompt,
        "max_tokens": 400,
      })
    })
    .then(response => response.json())
    .then(json_data => {
      const result = json_data.choices[0].text.trim();
      // 結果をmore-descriptionに表示
      document.querySelector('#more-description').textContent = result;
    });
  }
});
