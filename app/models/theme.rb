class Theme < ApplicationRecord
	has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  belongs_to :group

  def self.pluck_fields
    [:id, :title]
  end
end
