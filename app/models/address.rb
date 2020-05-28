class Address < ApplicationRecord
  belongs_to :user, optional: true
  has_many :purchases

  validates :family_name, :first_name , :family_name_kana, :first_name_kana, :zipcode, :prefecture, :city, :town, :town_number,  presence: true
  validates :family_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角文字のみ" }
  validates :family_name_kana,:first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "全角カナのみ" }
  validates :zipcode, length: {in: 7..7}
end
