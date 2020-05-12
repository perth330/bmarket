class Address < ApplicationRecord
  belongs_to_active_hash :prefecture
  belongs_to :user
end
