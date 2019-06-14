class UsersController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @userbody = @user.user_body
  end

  def show
    @user = User.find(params[:id])
    @training_records = @user.training_records
    @userbody = @user.user_body
    @training_record =  TrainingRecord.new
    @training_record.menus.build
    @day_records = @training_records.where(date: Date.today )
  end

  def records_update
    @day_records = TrainingRecord.where(user_id: params[:id], date: params[:date])
    render partial: "shared/training_records", collection: @day_records, as: "day_record"
  end
end
