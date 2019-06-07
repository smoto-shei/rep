class TrainingRecordsController < ApplicationController
     def index
      # @records = User.find(current_user.id).trainig_records
      @user = User.find(current_user.id)
    end

    def create
      @training_record = TrainingRecord.new(training_record_params)
      @training_record.save
    end

    def chest
      @user = User.find(current_user.id)
      @chest = TrainingRecord.where(user_id: current_user.id)
      @training_records = @user.training_records
      @userbody = @user.user_body
      gon.label = [1,2,3,4,5,6]
      gon.data = [300,300,300,300,300,300]
      render :index
    end

  private
  def training_record_params
    params.require(:training_record).permit(:date, :part, :exercise, menus_attributes: [:weight, :rep, :time]).merge(user_id: current_user.id)
  end

end
