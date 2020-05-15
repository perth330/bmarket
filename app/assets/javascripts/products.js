$(function() {
  function addCategoryCell(family) {
    let html = `
    <select class="categoryCell__${family} productsNewInput" name="product[category_id]" id="product_category"><option value>選択してください</option>
    `;
    $(".details__categoryCell").append(html);
  }
  
  function addCategory(category,family) {
    let html = `
    <option class="${family}Select" value="${category.id}">${category.name}</option>
    `;
    $(".categoryCell__" + family).append(html);
  }
  
  function addEnd(){
    let html = `
    </select>
    `;
    $(".details__categoryCell").append(html);
  }
  
  $(document).on("change",".categoryCell__parent", function() {
    $(".categoryCell__grandChild").remove();
    let parent_id = $(this).val()
    $.ajax({
      type: "GET",
      url: "/categories",
      data: { keyword: parent_id },
      dataType: "json"
    })
    .done(function(categories) {
      if (categories.length !== 0) {
        if ($(".categoryCell__child").length == 0){
          addCategoryCell("child")
        } else {
          $(".childSelect").remove()
        }
        categories.forEach(function(category) {
          addCategory(category,"child")
          addEnd()
        });
      } else if (input.length == 0) {
        return false;
      } else {
        return false;
      }
    })
  })
  
  $(document).on("change",".categoryCell__child", function() {
    let parent_id = $(this).val()
    $.ajax({
      type: "GET",
      url: "/categories",
      data: { keyword: parent_id },
      dataType: "json"
    })
    .done(function(categories) {
      if (categories.length !== 0) {
        if ($(".categoryCell__grandChild").length == 0){
          addCategoryCell("grandChild")
        } else {
          $(".grandChildSelect").remove()
        }
        categories.forEach(function(category) {
          addCategory(category,"grandChild")
        });
        addEnd()
      } else if (input.length == 0) {
        return false;
      } else {
        return false;
      }
    })
  })
  
  // 画像用のinputを生成する関数
  function buildFileField(index){
    const html = `
    <label data-index="${index}" class="uploadBox__box" for="product_images_attributes_${index}_image_url"><input class="uploadBox__box__hidden" type="file" name="product[images_attributes][${index}][image_url]" id="product_images_attributes_${index}_image_url">
    <div class="uploadBox__box__text">
    <i class="fa fa-camera uploadBox__box__text--message"></i>
    <p class="uploadBox__box__text--message hidden">ドラッグアンドドロップ</p>
    <p class="uploadBox__box__text--message hidden">またはクリックしてファイルをアップロード</p>
    </div>
    <div class="uploadBox__box__imageRemove">削除</div>
    </label>`;
    return html;
  }
  
  function previewImage(index,url){
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px" class="uploadBox__box__preview">`;
    return html;
  }
  
  
  $(document).on("change",'.uploadBox__box__hidden',function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      $(this).parent().append(previewImage(targetIndex,blobUrl))
      $(this).parent().append(`<div class="uploadBox__box__imageRemove">削除</div>`)
      $(".uploadBox__box__text--message").addClass("hidden");
      $('.uploadBox').append(buildFileField($(".uploadBox__box__hidden").length));
    }
  });
  $(document).on("click",".uploadBox__box__imageRemove",function() {
    $(this).parent().remove();
    $(".uploadBox__box").each(function(i){
      $(this).attr("data-index",i)
    })
    if ($('.uploadBox__box').length == 0) {
      $('.uploadBox').append(buildFileField(fileIndex[0]));
      $(".uploadBox__box__text--message").removeClass("hidden");
    }
  });
});





