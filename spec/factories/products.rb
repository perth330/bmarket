FactoryBot.define do

  factory :product do
    name            {"商品名"}
    introduction    {"説明"}
    condition       {"新品、未使用"}
    delivery_cost   {"着払い（購入者負担）"}
    from            {"北海道"}
    delivery_day    {"2〜3日で発送"}
    price           {"500"}
    size            {"S"}
    status          {"出品中"}
    user_id            {"1"}
    brand_id           {"1"}
    category_id        {"1"}

  end

end