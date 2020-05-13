$(function() {
  $(".details__brand").on("change",function(){
    let keyword = $(".details__brand").val();
    let url = "/brands/new"
    $.ajax({
      url: url,
      type: "GET",
      data: { keyword: keyword },
      dataType: 'json',
    })
    .done(function(brand){
      if ( brand.id == null ){
        $(".details__brandId").attr("value","0")
      } else {
        $(".details__brandId").attr("value",brand.id)
      }
    })
  })
})