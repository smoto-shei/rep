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
      a = user.training_records.where(part: part)
    end
  end

  def self.make_data_for_month(records) # 半月分の総負荷量算出
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

  def self.make_data_for_week(records)
    records = records.sort_by {|rec| rec.date} #配列を先頭から日付順(本日に近い順、降順)にする
    today = Date.today
    this_week = today + (7 - today.wday) # wdayは、(月火水木金土日) = (1,2,3,4,5,6,7) と対応している。 7 - today.wday とすることで週末を出している
    start_week = records[-1].date - (6 - records[-1].date.wday) # レコードの最初の日を割り出す(使わないかもしれないが今後期間を伸ばすときにおいておく)
    training_period = (this_week - records[-1].date).numerator # 最初のレコードから今週末までの日にち

    # 空配列の中身を何個作るか算出
    if training_period % 7 == 0
      arr_num = training_period / 7 + 1
    else
      arr_num = training_period / 7 + 2
    end
    amount = Array.new(6) {|i| i = 0} #空の配列を用意。将来的に =>[arr_num,6].max

    # ------------------------------- レコードごとの負荷量の算出
    records.each do |record|
      total = 0

      record.menus.each do |menu|
        if menu[:time] != nil
          total += menu[:time]
        else
          total += menu[:weight] * menu[:rep]
        end
      end

      diff = (this_week - record.date).numerator / 7 # 週末の日とレコードの日の差分。0なら今週、1なら先週...
      next if diff >= 6 #のちに配列の数は増やす
      amount[diff] += total
    end

    amount.reverse
  end

end
