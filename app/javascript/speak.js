document.getElementById("read-aloud").addEventListener("click", function() {
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
    var audio = new Audio('data:audio/mp3;base64,' + data.audioContent);
    audio.play();
  });
});

