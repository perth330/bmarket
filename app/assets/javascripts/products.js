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
})


