class Menu < ApplicationRecord
  belongs_to :training_record
  validates :weight, presence: true, unless: :time?
  validates :rep, presence: true, unless: :time?
  validates :time, presence: true, unless: :weight?
  validates :time, presence: true, unless: :rep?
end
