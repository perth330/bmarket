$(function(){
  function compareAddress(fromAddress,forAddress){
    let result = ""
    if ( fromAddress != forAddress ){
      for(let i = 0;i < forAddress.length; i++){
        if (fromAddress.charAt(i) == forAddress.charAt(i)){
          result += forAddress.charAt(i)
        } else {
          break;
        }
      }
      return result
    } else {
      return forAddress
    }
  }
  $(document).on("keyup","#address_zipcode",function(e){
    zipcode = $("#address_zipcode").val()
    if (zipcode.length == 7){
      url = "https://zipcloud.ibsnet.co.jp/api/search?callback=?"
      $.getJSON( url, {
        zipcode: zipcode
      })
      .done(function(addresses) {
        if (addresses.status == "200") {
          if (addresses.results == null ){
            alert("入力された郵便番号は存在しません。")
          } else {
            $("#address_prefecture").val(addresses.results[0].prefcode)
            if (addresses.results.length == 1) {
              $("#address_city").val(addresses.results[0].address2)
              $("#address_town").val(addresses.results[0].address3)
            } else {
              addresses.results.forEach(function(address,i){
                if (i == 0) {
                  compAddress2 = address.address2
                  compAddress3 = address.address3
                } else {
                  compAddress = compareAddress(address.address2,compAddress2)
                  compAddress2 = compAddress
                  compAddress = compareAddress(address.address3,compAddress3)
                  compAddress3 = compAddress
                }
              })
              $("#address_city").val(compAddress2)
              $("#address_town").val(compAddress3)
            }
          }
        } else {
          alert(addresses.message)
        }
      })
    }
  })
})