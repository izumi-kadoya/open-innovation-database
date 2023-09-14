$(document).on('turbolinks:load', function() { // Turbolinksとの互換性を確保するためにこれを使用します
  $('#fetch-info-button').on('click', function() {
      var recordUrl = $(this).data('record-url'); // ボタンのデータ属性からURLを取得

      $.ajax({
          url: '/records/fetch_info',
          method: 'POST',
          data: { url: recordUrl },
          dataType: 'json',
          success: function(response) {
              if (response && response.message) {
                  $('.more-description').html(response.message.content);
              } else {
                  $('.more-description').html('Failed to fetch information.');
              }
          },
          error: function() {
              $('.more-description').html('Error occurred while fetching information.');
          }
      });
  });
});
