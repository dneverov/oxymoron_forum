class Group < ApplicationRecord
  has_many :themes, ->{order(:id)}, dependent: :destroy
  has_many :topics, through: :themes, dependent: :destroy
  has_many :posts, through: :topics, dependent: :destroy
end
