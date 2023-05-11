$(document).on('turbolinks:load', function() {
  $(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
    $(".img_prev").attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $(document).on('change', '.img_field', function(){
      readURL(this);
    });
  });
});