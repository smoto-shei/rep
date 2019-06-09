class TrainingRecordsController < ApplicationController
    before_action :set_user, except: [:create]
    before_action :set_userbody,except: [:create]
    before_action :set_month, except: [:index, :create]


    def index
      # @records = User.find(current_user.id).trainig_records
    end

    def create
      @training_record = TrainingRecord.new(training_record_params)
      @training_records = TrainingRecord.where(user_id: current_user.id, date: params[:training_record][:date])
      unless @training_record.save
        render status: 400, body: nil
      end
    end

    def destroy
      @training_record = TrainingRecord.find_by(id: params[:id])
      if current_user.id == @training_record.user_id
        date = @training_record.date
        @training_record.destroy
        @training_records = TrainingRecord.where(user_id: params[:user_id], date: date)
        render partial: "shared/day_records_on_calendar", locals: { training_records: @training_records }
      end
    end

    def chest
      @training_records = @user.training_records.where(part: '胸')
      gon.part = '胸'
      gon.label = (@mon-5..@mon).to_a.map {|a| a.to_s + '月'}
      gon.data = TrainingRecord.make_chart_data(@training_records)
      render :index
    end

    def sholder
      @training_records = @user.training_records.where(part: '肩')
      gon.part = '肩'
      gon.label = (@mon-5..@mon).to_a.map {|a| a.to_s + '月'}
      gon.data = TrainingRecord.make_chart_data(@training_records)
      render :index
    end

    def arm
      @training_records = @user.training_records.where(part: '腕')
      gon.part = '腕'
      gon.label = (@mon-5..@mon).to_a.map {|a| a.to_s + '月'}
      gon.data = TrainingRecord.make_chart_data(@training_records)
      render :index
    end

    def back
      @training_records = @user.training_records.where(part: '背中')
      gon.part = '背中'
      gon.label = (@mon-5..@mon).to_a.map {|a| a.to_s + '月'}
      gon.data = TrainingRecord.make_chart_data(@training_records)
      render :index
    end

    def leg
      @training_records = @user.training_records.where(part: '脚')
      gon.part = '脚'
      gon.label = (@mon-5..@mon).to_a.map {|a| a.to_s + '月'}
      gon.data = TrainingRecord.make_chart_data(@training_records)
      render :index
    end

    def aerobic
      @training_records = @user.training_records.where(part: '有酸素')
      gon.part = '有酸素'
      gon.label = (@mon-5..@mon).to_a.map {|a| a.to_s + '月'}
      gon.data = TrainingRecord.make_chart_data_aerobic(@training_records)
      render :index
    end



  private

  def training_record_params
    params.require(:training_record).permit(:date, :part, :exercise, menus_attributes: [:weight, :rep, :time]).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def set_userbody
    @userbody = @user.user_body
  end

  def set_month
    @mon = Date.today.month
  end

end
