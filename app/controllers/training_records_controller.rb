class TrainingRecordsController < ApplicationController
  def index
      # @records = User.find(current_user.id).trainig_records
      @user = User.find(current_user.id)
      @training_records = @user.training_records
      @userbody = @user.user_body
  end

  def create
    @training_record = TrainingRecord.new(training_record_params)
    @training_record.menus.build
    @training_record.save
  end



  
  private
  def training_record_params
    params.permit(:date, :part, :exercise, menus_attributes:[:id, :training_record_id, :weight, :rep, :time]).merge(user_id: current_user.id)
  end

end
