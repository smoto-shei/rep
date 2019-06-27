class Menu < ApplicationRecord
  belongs_to :training_record
  validates :weight, presence: true, unless: :part_type?, inclusion: { in: 0..999.5 }
  validates :rep, presence: true, unless: :part_type?, inclusion: { in: 0..999}
  validates :time, presence: true, if: :part_type?, inclusion: { in: 0..1440 }

  def part_type?
    training_record.part == '有酸素'
  end

end
