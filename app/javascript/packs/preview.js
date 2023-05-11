$(document).on('turbolinks:load', function() {
  $('.img_field').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".img_prev").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});