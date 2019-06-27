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


    end
  end
end