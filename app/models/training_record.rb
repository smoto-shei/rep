class TrainingRecord < ApplicationRecord
  has_many :menus
  accepts_nested_attributes_for :menus, allow_destroy: true
end
