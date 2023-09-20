document.getElementById("read-aloud").addEventListener("click", function() {
  var text = document.querySelector(".more-description").innerText;

  fetch('/records/text_to_speech', {
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
    var audio = new Audio('data:audio/mp3;base64,' + data.audioContent);
    audio.play();
  });
});
