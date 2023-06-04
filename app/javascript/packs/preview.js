$(document).on('turbolinks:load', function() {
  $('.img_field').on('change', function (e) {
    if (e.target.files.length > 4) {
      alert('一度に投稿できるのは五枚までです。');
      $('.img_field').val("");
      for (var i = 0; i < 4; i++) {
        $('#preview_' + i).attr('src', "");
      }
    } else {
      for (var i = 0; i < 4; i++) {
        $('#preview_' + i).attr('src', "");
      }
      for (var i = 0; i < e.target.files.length && i < 4; i++) {
        var reader = new FileReader();
        reader.onload = (function (index) {
          return function (e) {
            $('#preview_' + index).attr('src', e.target.result);
          };
        })(i);
        reader.readAsDataURL(e.target.files[i]);
      }
    }
  });
});
