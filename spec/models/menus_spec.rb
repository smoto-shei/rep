require 'rails_helper'

RSpec.describe Menu, type: :model do

  before do
    @menu = FactoryBot.build(:menu)

  end

  describe Menu do
    describe '#create' do

      it "有酸素の種目を投稿できる" do
        @menu.training_record.update(part: "有酸素")
        @menu.weight = nil
        @menu.rep = nil
        expect(@menu).to be_valid
      end

      it "有酸素以外の種目を投稿できる" do
        @menu.training_record.update(part: "胸")
        @menu.time = nil
        expect(@menu).to be_valid
      end

      it "有酸素種目の場合、timeがなければ投稿できない" do
        @menu.training_record.update(part: "有酸素")
        @menu.time = nil
        @menu.valid?
        expect(@menu.errors[:time]).to include("を入力してください") 
      end

      it "有酸素以外の種目の場合、weightがなければ投稿できない" do
        @menu.training_record.update(part: "肩")
        @menu.weight = nil
        @menu.valid?
        expect(@menu.errors[:weight]).to include("を入力してください")
      end

      it "有酸素以外の種目の場合、repがなければ投稿できない" do
        @menu.training_record.update(part: "背中")
        @menu.rep = nil
        @menu.valid?
        expect(@menu.errors[:rep]).to include("を入力してください")
      end

      it "weightが1000以上の場合は投稿できない" do
        @menu.training_record.update(part: "胸")
        @menu.weight = 1000
        @menu.valid?
        expect(@menu.errors[:weight]).to include("は1000より小さい値にしてください")
      end

      it "weightが1000未満の場合は投稿できる" do
        @menu.training_record.update(part: "肩")
        @menu.weight =  999.5
        expect(@menu).to be_valid
      end

      it "weightが0未満の場合は投稿できない" do
        @menu.training_record.update(part: "胸")
        @menu.weight = -1
        @menu.valid?
        expect(@menu.errors[:weight]).to include("は0以上の値にしてください")
      end

      it "weightが0以上の場合は投稿できる" do
        @menu.training_record.update(part: "背中")
        @menu.weight =  0
        expect(@menu).to be_valid
      end

      it "repが1000以上の場合は投稿できない" do
        @menu.training_record.update(part: "胸")
        @menu.rep = 1000
        @menu.valid?
        expect(@menu.errors[:rep]).to include("は1000より小さい値にしてください")
      end

      it "repが1000未満の場合は投稿できる" do
        @menu.training_record.update(part: "腕")
        @menu.rep = 999
        expect(@menu).to be_valid
      end

      it "repが0未満の場合は投稿できない" do
        @menu.training_record.update(part: "胸")
        @menu.rep = -1
        @menu.valid?
        expect(@menu.errors[:rep]).to include("は0以上の値にしてください")
      end

      it "repが0以上の場合は投稿できる" do
        @menu.training_record.update(part: "脚")
        @menu.rep = 0
        expect(@menu).to be_valid
      end

      it "timeが1440を超過した場合は投稿できない" do
        @menu.training_record.update(part: "有酸素")
        @menu.time = 1441
        @menu.valid?
        expect(@menu.errors[:time]).to include("は1440以下の値にしてください")
      end

      it "timeが1440以下の場合は投稿できる" do
        @menu.training_record.update(part: "有酸素")
        @menu.rep = 1440
        expect(@menu).to be_valid
      end

      it "timeが0未満の場合は投稿できない" do
        @menu.training_record.update(part: "有酸素")
        @menu.time = -1
        @menu.valid?
        expect(@menu.errors[:time]).to include("は0以上の値にしてください")
      end

      it "timeが0以上の場合は投稿できる" do
        @menu.training_record.update(part: "有酸素")
        @menu.time = 0
        expect(@menu).to be_valid
      end

    end
  end
end