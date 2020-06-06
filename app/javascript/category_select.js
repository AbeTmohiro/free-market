document.addEventListener('turbolinks:load', function () {
  //↓カテゴリのフォームが無いなら以降実行しない。
  if (!$('.select-category')[0]) return false;
  //↓子孫カテゴリのフォームを組み立てる。
  function buildCategoryForm(categories) {
    let options = "";
    //↓カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
    categories.forEach(function (category) { 
      // ↓カテゴリIDを取得し、nameを表示
      options += `
                  <option value="${category.id}">${category.name}</option>
                 `;
    });
    const html = `
                  <select required="required" class="select-category" name="item[category_id]">
                    <option value="">---</option>
                    ${options}
                  </select>
                  `;
    return html;
  }
  //↓カテゴリが選択された時
  $(".input-field-main").on("change", ".select-category", function () { 
    const category_id = $(this).val();
    var changed_form = $(this);
    $.ajax({
      url: "/api/categories",
      type: "GET",
      data: {
        category_id: category_id
      },
      dataType: 'json',
    })
    .done(function (categories) {
      if (categories.length == 0) return false;
      // ↓nextAllメソッド=「後ろにある要素全て」、この場合は(.select-category)の子孫カテゴリ
      changed_form.nextAll(".select-category").remove();
      const html = buildCategoryForm(categories);
      // ↓入力されたselect-categoryの最後を取得し、その後ろにhtmlを追加。
      $(".select-category:last").after(html);
    })
    .fail(function () {
      alert('error');
    })
  });
});