  $(".details__brand").on("change",function(){
    let formData = new FormData(this);
    let url = "/brands/new"
    $.ajax({
      url: url,
      type: "POST",
      data: {
        keyword: formData
      },
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(brand){
      if ( brand.length == 0 ){
        $(".details__brandId").attr("value") = 0
      } else {
        $(".details__brandId").attr("value") = brand.id
      }
    })
  })