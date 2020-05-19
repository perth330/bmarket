FactoryBot.define do

  factory :address do
    family_name           {"名前"}
    first_name            {"次郎"}
    family_name_kana      {"ナマエ"}
    first_name_kana       {"ジロウ"}
    prefecture            {"31"}
    city                  {"大阪市"}
    town                  {"中央区難波"}
    town_number           {"5-1-60"}
    zipcode               {"5420076"}

    association :user, factory: :user
  
  end

end