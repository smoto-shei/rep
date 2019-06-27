require 'rails_helper'

RSpec.describe TrainingRecord, type: :model do

  before do
    @training_record = FactoryBot.build(:training_record)
  end

  describe TrainingRecord do
    describe '#create' do
      
      it "投稿できる" do
        expect(@training_record).to be_valid
      end

      it "部位(part)なしでは投稿できない" do
        @training_record.part = ''
        @training_record.valid?
        expect(@training_record.errors[:part]).to include("を入力してください")
      end

      it "日付(date)なしでは投稿できない" do
        @training_record.date = ''
        @training_record.valid?
        expect(@training_record.errors[:date]).to include("を入力してください")
      end

      it "種目(exercise)なしでは投稿できない" do
        @training_record.exercise = ''
        @training_record.valid?
        expect(@training_record.errors[:exercise]).to include("を入力してください")
      end

    end
  end
end