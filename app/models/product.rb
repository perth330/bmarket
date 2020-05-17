class Product < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

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
  validates :user_id, presence: true
  validates :brand_id, presence: true
  validates :category_id, presence: true
  validates :images, presence: true

  # - has_many :comments, dependent: :destroy
  # - has_one :dealing, dependent: :destroy
  # - has_many :products_tags
  # - has_many :tags,  through:  :products_tags
end
