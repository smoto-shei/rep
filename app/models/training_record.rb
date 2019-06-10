class TrainingRecord < ApplicationRecord
  belongs_to :user
  has_many :menus, dependent: :destroy
  validates :part, presence: true
  validates :exercise, presence: true
  accepts_nested_attributes_for :menus, allow_destroy: true

  def self.bring_training_data(user,part)
    if part == 'Total'
      user.training_records
    else
      user.training_records.where(part: part)
    end
  end

  def self.make_chart_data(records) # 半月分の総負荷量算出
    # --------------------------- バケット作成 例:今月が６月の場合 => {1:0, 2:0, 3:0, 4:0, 5:0, 6:0}
    amount = Hash.new
    month = Date.today.month # Date.today.month で現在の月を出す
    start = month - 5        # スタートは今月の５ヶ月前
    start.upto(month) do |mon|
      amount[mon] = 0
    end
    # --------------------------- 負荷量の算出
    records.each do |record|
      total = 0
      record.menus.each do |menu|
        if menu[:time] != nil
          total += menu[:time]
        else
          total += menu[:weight] * menu[:rep]
        end
      end
      amount[record.date.month] += total  #record.date.month でtraining_record の date型から実施された月を出す
    end
    amount.values # hash をバリューのみの配列にする {1:100, 2:100, 3:400, 4:2500, 5:1600, 6:2800.5} =>[100.0, 100.0, 400.0, 2500.0, 1600.0, 2800.5]
  end
end
