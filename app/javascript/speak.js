let audio;
let isPlaying = false;
let isLoaded = false;

document.getElementById("read-aloud").addEventListener("click", function() {
  if (!isLoaded) { // 初めてのクリック
    var text = document.querySelector('.more-description').innerText;
    const recordId = this.getAttribute('record-id');
    fetch(`/records/${recordId}/text_to_speech`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ text: text })
    })
    .then(response => response.json())
    .then(data => {
      audio = new Audio('data:audio/mp3;base64,' + data.audioContent);
      audio.play();
      isPlaying = true;
      isLoaded = true;

      audio.addEventListener("ended", function() { // 音声が終わった場合のリセット
        isPlaying = false;
        isLoaded = false;
      });
    });

  } else {
    if (isPlaying) { // 既に再生中の場合、一時停止する
      audio.pause();
      isPlaying = false;
    } else { // 一時停止中の場合、再開する
      audio.play();
      isPlaying = true;
    }
  }
});

// 停止する
document.getElementById("stop-aloud").addEventListener("click", function() {
  if (isLoaded && isPlaying) {
    audio.pause();
    audio.currentTime = 0; // オーディオの再生位置を初期位置にリセット
    isPlaying = false;
    isLoaded = false; 
  }
});