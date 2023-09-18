document.getElementById("read-aloud").addEventListener("click", function(event) {
  const textToRead = document.getElementById("more-description").innerText;
  const requestBody = {
    text: textToRead
  };
});
let isPlaying = false;

document.getElementById("read-aloud").addEventListener("click", function() {
  const textToRead = document.getElementById("more-description").innerText;

  const requestBody = {
    text: textToRead
  };

  // Railsのエンドポイントにリクエストする
  fetch(`/records/synthesize`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(requestBody)
  })
  .then(response => response.json()) // レスポンスをJSONとして解析
  .then(data => {
    // レスポンスデータを使用
    audio.src = "data:audio/mp3;base64," + data.audioContent;
    audio.play().then(() => {
      isPlaying = true;
    }).catch((error) => {
      console.error("Audio play failed:", error);
    });
  });
});

// 一時停止
function togglePauseResume() {
  if (isPlaying) {
    audio.pause();
    isPlaying = false;
  } else {
    audio.play().then(() => {
      isPlaying = true;
    }).catch((error) => {
      console.error("Audio play failed:", error);
    });
  }
}

document.querySelector("#toggle-pause").addEventListener("click", function() {
  togglePauseResume();
});
