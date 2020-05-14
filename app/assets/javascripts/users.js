  $(document).on("change",".birthdaySelect__form", function() {
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