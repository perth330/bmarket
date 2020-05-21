FactoryBot.define do

  factory :user do
    family_name {"名字"}
    first_name  {"名前"}
    family_name_kana {"ミョウジ"}
    first_name_kana {"ナマエ"}
    nickname {"テストユーザー１"}
    email {"test1@test.com"}
    password {"test1pass"}
    password_confirmation {"test1pass"}
    birthday {"1991-11-23"}

  end

end