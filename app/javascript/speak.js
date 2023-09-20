let audio = new Audio(); // 音声を再生するためのオブジェクト
let isPlaying = false;   // 再生状態を追跡するためのフラグ

document.getElementById("read-aloud").addEventListener("click", function() {
  if (!isPlaying) { // 音声が再生中でない場合のみAPIを叩く
    var text = document.querySelector(".more-description").innerText;
    var apiKey = document.body.getAttribute("data-google-cloud-api-key");

    fetch('https://texttospeech.googleapis.com/v1/text:synthesize?key=' + apiKey, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        input: {
          text: text
        },
        voice: {
          languageCode: 'en-US',
          ssmlGender: 'NEUTRAL'
        },
        audioConfig: {
          audioEncoding: 'MP3'
        }
      })
    })
    .then(response => response.json())
    .then(data => {
      audio.src = 'data:audio/mp3;base64,' + data.audioContent;
      audio.play();
      isPlaying = true;
    });
  } else {
    audio.pause();
    isPlaying = false;
  }
});

document.getElementById('toggle-pause').addEventListener('click', function() {
  if (isPlaying) {
    audio.pause();
  } else {
    audio.play();
  }
  isPlaying = !isPlaying;
});

audio.addEventListener('ended', function() {
  isPlaying = false;
});
