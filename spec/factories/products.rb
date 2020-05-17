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
    association :user, factory: :user
    association :brand, factory: :brand
    association :category, factory: :category
    after(:build) do |product|
      product.images<< build(:image, product: product)
    end
  end

  factory :product_without_image do
    name            {"商品名"}
    introduction    {"説明"}
    condition       {"新品、未使用"}
    delivery_cost   {"着払い（購入者負担）"}
    from            {"北海道"}
    delivery_day    {"2〜3日で発送"}
    price           {"500"}
    size            {"S"}
    status          {"出品中"}
    association :user, factory: :user
    association :brand, factory: :brand
    association :category, factory: :category
  end
end