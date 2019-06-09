class TrainingRecord < ApplicationRecord
  belongs_to :user
  has_many :menus, dependent: :destroy
  validates :part, presence: true
  validates :exercise, presence: true
  accepts_nested_attributes_for :menus, allow_destroy: true
end
