class Menu < ApplicationRecord
  belongs_to :training_record
  validates :weight, presence: true, inclusion: { in: 0..999.5 }, unless: :part_type?
  validates :rep, presence: true, inclusion: { in: 0..999}, unless: :part_type?
  validates :time, presence: true, inclusion: { in: 0..1440 }, if: :part_type?

  private

  def part_type?
    training_record.part == '有酸素'
  end

end
