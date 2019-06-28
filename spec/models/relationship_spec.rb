require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user_a) {FactoryBot.create(:user)}
  let(:user_b) {FactoryBot.create(:user)}

  before do
    @relationship = FactoryBot.build(:relationship)
    @relationship.user_id = user_a.id
    @relationship.follow_id = user_b.id
  end

  describe '有効なrelationship' do
    it 'relationshipの検証' do
      expect(@relationship).to be_valid
    end
  end

  describe '無効なrelationship' do
    it 'user_id == follow_id' do
      @relationship.follow_id = user_a.id
      expect(@relationship).not_to be_valid
    end

    it 'user_id == nil' do
      @relationship.user_id = nil
      expect(@relationship).not_to be_valid
    end

    it 'follow_id == nil' do
      @relationship.follow_id = nil
      expect(@relationship).not_to be_valid
    end
  end

end
