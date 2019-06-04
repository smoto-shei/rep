class TrainingRecordsController < ApplicationController
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
