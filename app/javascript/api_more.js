const fetchInfoButton = document.getElementById('fetch-info-button');

if (fetchInfoButton) {
  fetchInfoButton.addEventListener('click', function() {
    const recordUrl = fetchInfoButton.getAttribute('data-url'); 

    fetch('/records/fetch_info', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({ 


        url: recordUrl }),
    })
    .then(response => response.json())
    .then(data => {
      const moreDescription = document.querySelector('.more-description');
      
      // レスポンスの内容に基づいて、説明文またはエラーメッセージを表示
      if (data && data.description) {
        moreDescription.innerHTML = data.description;
      } else if (data && data.error) {
        moreDescription.innerHTML = data.error;
      } else {
        moreDescription.innerHTML = 'Unexpected response format.';
      }
    })
    .catch(() => {
      const moreDescription = document.querySelector('.more-description');
      moreDescription.innerHTML = 'Error occurred while fetching information.';
    });
  });
}
