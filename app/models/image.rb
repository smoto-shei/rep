class Image < ApplicationRecord
  belongs_to :user
  validates :user_image, presence: true
  validates :user_image, dependent: :destroy

end
