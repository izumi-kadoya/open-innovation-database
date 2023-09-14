document.addEventListener('DOMContentLoaded', function() {
  const fetchInfoButton = document.getElementById('fetch-info-button');

  if (fetchInfoButton) {
      fetchInfoButton.addEventListener('click', function() {
          const recordUrl = fetchInfoButton.getAttribute('data-url');

          fetch('/records/fetch_info', {
              method: 'POST',
              headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
              },
              body: JSON.stringify({ url: recordUrl }),
          })
          .then(response => response.json())
          .then(data => {
              const moreDescription = document.querySelector('.more-description');
              if (data && data.message) {
                  moreDescription.innerHTML = data.message.content;
              } else {
                  moreDescription.innerHTML = 'Failed to fetch information.';
              }
          })
          .catch(() => {
              const moreDescription = document.querySelector('.more-description');
              moreDescription.innerHTML = 'Error occurred while fetching information.';
          });
      });
  }
});
