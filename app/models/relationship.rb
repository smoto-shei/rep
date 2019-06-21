class Relationship < ApplicationRecord
  belongs_to :user
  # Userクラスを参照するように明示。Userモデルにbelongs_toさせる
  belongs_to :follow, class_name: 'User'
  validates :user_id, presence: true
  validates :follow_id, presence: true
end