require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user_a) FactoryBot.build(:user)
  let(:user_b) FactoryBot.build(:user)

  before do
    @relationship = FactoryBot.build(:relationship)
  end

  describe '有効なrelationship' do
    it '有効なrelationship' do
      expect(@relationship).to be_valid
    end
  end


end
