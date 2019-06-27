require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:dummy_image) {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/dummy_image.rb'))}

  before do
    @image = FactoryBot.build(:image)
  end

  describe Image do

    describe '#create' do
      it "投稿できる" do
        expect(@image).to be_valid
      end

      it "コメントなしでも投稿できる" do
        @image.comment = ''
        expect(@image).to be_valid
      end

      it "画像なしの投稿はできない" do
        @image.user_image = []
        @image.valid?
        expect(@image.errors[:user_image]).to include("を入力してください")
      end

      it "画像ファイルの拡張子が適切でない場合は投稿できない" do
        @image.user_image = [dummy_image]
        @image.valid?
        expect(@image).not_to be_valid
      end
    end

  end
end