crumb :root do
  link "トップページ", root_path
end
crumb :mypage do
  link "マイページ", user_path(current_user)
end
crumb :address do
  link "お届け先住所登録", addresses_path
  parent :mypage
end
crumb :addressesnew do
  link "お届け先住所新規登録", new_address_path
  parent :mypage
end
crumb :credit do
  link "支払い方法", credit_path(params[:id])
  parent :mypage
end
crumb :product do
  link "商品詳細ページ", product_path(params[:id])
  parent :root
end
crumb :productsnew_from_user do
  link "商品出品ページ", new_product_path
  parent :mypage
end
crumb :productsnew_from_top do
  link "商品出品ページ", new_product_path
  parent :root
end
crumb :productsedit do
  link "商品情報編集ページ", edit_product_path(params[:id])
  parent :product
end
