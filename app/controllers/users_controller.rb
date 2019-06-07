class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @training_records = @user.training_records
    @userbody = @user.user_body
    @training_record =  TrainingRecord.new
    @training_record.menus.build

    respond_to do |format|
      format.json do
        @day_records = @training_records.where(date: params[:date])
        render json: { day_records: @day_records }
      end
      format.html do
        @day_records = @training_records.where(date: Date.today )
      end
    end
  end

  def records_update
    @day_records = TrainingRecord.where(user_id: params[:id], date: params[:date])
    render partial: "shared/training_records", collection: @day_records, as: "day_record"
    
  end

end