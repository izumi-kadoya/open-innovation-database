document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("#read-aloud").addEventListener("click", function() {
    readAloud();
  });

  document.querySelector("#toggle-pause").addEventListener("click", function() {
    togglePauseResume();
  });

  function readAloud() {
    const textToSpeak = document.querySelector('.more-description').textContent;
    const utterance = new SpeechSynthesisUtterance(textToSpeak);

    utterance.lang = 'en-US';
    utterance.rate = 1;

    utterance.onstart = function() {
        console.log("Speech synthesis started");
    };
    utterance.onerror = function(event) {
      console.error("Speech synthesis error:", event.error);
    };
    utterance.onend = function() {
      console.log("Speech synthesis ended");
    };

    // キューにある発話をキャンセル
    speechSynthesis.cancel();

    // 発話を開始
    window.speechSynthesis.speak(utterance);
}


  function togglePauseResume() {
    if (speechSynthesis.paused) {
      speechSynthesis.resume();
    } else if (speechSynthesis.speaking) {
      speechSynthesis.pause();
    }
  }
});
