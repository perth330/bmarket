FactoryBot.define do

  factory :image do
    image_url {File.open("#{Rails.root}/public/uploads/image/cat458A8400.jpg")}
    association :product, factory: :product
  end

end