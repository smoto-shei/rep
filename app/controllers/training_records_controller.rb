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

    def sholder
      @user = User.find(current_user.id)
      @chest = TrainingRecord.where(user_id: current_user.id)
      @training_records = @user.training_records
      @userbody = @user.user_body
      gon.label = [1,2,3,4,5,6]
      gon.data = [300,200,100,300,300,150]
      render :index
    end

    def arm
      @user = User.find(current_user.id)
      @chest = TrainingRecord.where(user_id: current_user.id)
      @training_records = @user.training_records
      @userbody = @user.user_body
      gon.label = [1,2,3,4,5,6]
      gon.data = [2100,1300,1900,1500,2000,1000]
      render :index
    end

    def back
      @user = User.find(current_user.id)
      @chest = TrainingRecord.where(user_id: current_user.id)
      @training_records = @user.training_records
      @userbody = @user.user_body
      gon.label = [1,2,3,4,5,6]
      gon.data = [800,900,500,250,700,500]
      render :index
    end

    def leg
      @user = User.find(current_user.id)
      @chest = TrainingRecord.where(user_id: current_user.id)
      @training_records = @user.training_records
      @userbody = @user.user_body
      gon.label = [1,2,3,4,5,6]
      gon.data = [700,1200,1000,900,400,800]
      render :index
    end

    def aerobic
      @user = User.find(current_user.id)
      @chest = TrainingRecord.where(user_id: current_user.id)
      @training_records = @user.training_records
      @userbody = @user.user_body
      gon.label = [1,2,3,4,5,6]
      gon.data = [3000,4000,3200,3550,3900,2900]
      render :index
    end



  private
  def training_record_params
    params.require(:training_record).permit(:date, :part, :exercise, menus_attributes: [:weight, :rep, :time]).merge(user_id: current_user.id)
  end

end
