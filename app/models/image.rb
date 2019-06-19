class Image < ApplicationRecord
  belongs_to :user
  validates :user_image, presence: true
  mount_uploaders :user_image, ImagesUploader
  serialize :user_image, JSON
end
