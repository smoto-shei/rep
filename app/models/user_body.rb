class UserBody < ApplicationRecord
  belongs_to :user
  validates :weight, inclusion: { in: 20..350 }
  validates :height, inclusion: { in: 100..300 }
  mount_uploader :avatar, AvatarUploader


end
