document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //カテゴリのフォームが無いなら以降実行しない。
  $(".select-category").on("change", function () { //カテゴリが選択された時
  });
});