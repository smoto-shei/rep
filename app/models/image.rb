class Image < ApplicationRecord
  belongs_to :user
  validates :user_image, presence: true, dependent: :destroy

end
