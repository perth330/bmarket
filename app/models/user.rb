class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :email,    uniqueness: {case_sensitive: false},format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
    validates :password, length: {minimum: 7}
    
    with_options format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/} do
      validates :family_name
      validates :first_name
    end
    
    with_options format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/} do
      validates :family_name_kana
      validates :first_name_kana
    end
  end

  has_many :comments
  has_one :credit
  has_many :purchases
  has_many :addresses
  has_many :products
end
