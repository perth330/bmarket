// $(function() {
//   $(".details__brand").on("keyup",function(){
//     let keyword = $(".details__brand").val();
//     let url = "/brands"
//     $.ajax({
//       url: url,
//       type: "GET",
//       data: { keyword: keyword },
//       dataType: 'json',
//     })
//     .done(function(brands){
//       if ( brand.id == null ){
//         $(".details__brandId").attr("value","0")
//       } else {
//         $(".details__brandId").attr("value",brand.id)
//       }
//     })
//   })
// })