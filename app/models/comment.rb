class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :text, presence: true
  validates :user_id, presence: true
  validates :product_id, presence: true
end
