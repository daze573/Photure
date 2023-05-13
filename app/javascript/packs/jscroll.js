$(document).on('turbolinks:load', function() {
  var isLoading = false;  // ロード中フラグの初期化

  $(window).on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
      if (!isLoading) {  // ロード中でなければ新しいリクエストを開始
        isLoading = true;  // ロード中フラグを設定
        $('.jscroll').jscroll({
          contentSelector: '.scroll-list',
          nextSelector: 'span.next:last a',
          callback: function() {  // リクエストが完了したらフラグをリセット
            isLoading = false;
          }
        });
      }
    }
  });
});