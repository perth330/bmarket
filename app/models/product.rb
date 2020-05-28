class Product < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  has_one :purchase
  has_many :favorites, dependent: :destroy
  def like_user(product,user)
    Favorite.find_by(product_id:product,user_id: user)
   end

  enum status: { "出品中": 0, "売却済": 1 }

  validates_associated :images

  validates :name, presence: true
  validates :introduction, presence: true
  validates :condition, presence: true
  validates :delivery_cost, presence: true
  validates :from, presence: true
  validates :delivery_day, presence: true
  validates :price, numericality: { greater_than: 299, less_than: 1000000 }
  validates :size, presence: false
  validates :status, presence: true
  validates :images, presence: true

  has_many :comments, dependent: :destroy
  has_one :purchase, dependent: :destroy
  def self.search(search)
    return Product.all unless search
    Product.where('name LIKE(?)', "%#{search}%")
  end
end
