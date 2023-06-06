$(document).on('turbolinks:load', function() {
  $('[class^="img_field"]').on('change', function(e) {
    var index = $(this).data('index');
    var previewSelector = '.image-preview:eq(' + index + ')';
    var imagePreviewSelector = previewSelector + ' img';

    if (e.target.files.length > 4) {
      alert('一度に投稿できるのは五枚までです。');
      $(this).val("");
      $(imagePreviewSelector).attr('src', '');
    } else {
      $(imagePreviewSelector).attr('src', '');
      for (var i = 0; i < e.target.files.length && i < 4; i++) {
        var reader = new FileReader();
        reader.onload = (function(index, i) {
          return function(e) {
            var previewId = previewSelector + ' img:eq(' + i + ')';
            $(previewId).attr('src', e.target.result);
          };
        })(index, i);
        reader.readAsDataURL(e.target.files[i]);
      }
    }
  });
});
