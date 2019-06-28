class Relationship < ApplicationRecord
  belongs_to :user
  # Userクラスを参照するように明示。Userモデルにbelongs_toさせる
  belongs_to :follow, class_name: 'User'
  validates :user_id, presence: true
  validates :follow_id, presence: true
  validate :follow_id_eq_user_id?

  private

  def follow_id_eq_user_id?
    if user&.id == follow&.id
      errors.add(:follow_id, '自分をフォローすることはできません')
    end
  end

end