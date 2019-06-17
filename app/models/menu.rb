class Menu < ApplicationRecord
  belongs_to :training_record
  validates :weight, presence: true, unless: :time?, inclusion: { in: 0..999.5 }
  validates :rep, presence: true, unless: :time?, inclusion: { in: 0..999}
  validates :time, presence: true, unless: [:weight?, :rep?], inclusion: { in: 0..1440 }
end
