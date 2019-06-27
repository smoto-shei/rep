class Menu < ApplicationRecord
  belongs_to :training_record
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000 }, unless: :part_type?
  validates :rep, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000 }, unless: :part_type?
  validates :time, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1440 }, if: :part_type?

  private

  def part_type?
    training_record.part == '有酸素'
  end

end
