
document.addEventListener("DOMContentLoaded", function() {
  const api_key = window.apiKey; 
  const record_url = '<%= @record.url %>'; // この行でインスタンス変数を取得

  // ボタンクリック時の処理
  document.querySelector("#description_renew").addEventListener("click", function() {
    const prompt = `describe this startup. ${record_url}`; // プロンプトを生成
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
        "model": "gpt-3.5-turbo",
        "prompt":prompt,
        "max_tokens": 200,
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
