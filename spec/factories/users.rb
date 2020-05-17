FactoryBot.define do

  factory :user do
    family_name {"名字１"}
    first_name  {"名前１"}
    family_name_kana {"ミョウジ１"}
    first_name_kana {"ナマエ１"}
    nickname {"テストユーザー１"}
    email {"test1@test.com"}
    password {"test1pass"}
    password_confirmation {"test1pass"}
    birthday {"1991-11-23"}

  end

end