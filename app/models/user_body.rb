class UserBody < ApplicationRecord
  belongs_to :user
  validates :weight, inclusion: { in: 20..350 }, allow_nil: true
  validates :height, inclusion: { in: 100..300 }, allow_nil: true
  mount_uploader :avatar, AvatarUploader
end
