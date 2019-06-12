class TrainingRecordsController < ApplicationController
    before_action :set_user, except: [:create]
    before_action :set_userbody,except: [:create]
    before_action :set_month, except: :create
    before_action :set_gon_user_id, except: :create



    def index
      @userbody = @user.user_body
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

    def draw_graph
      @part = params[:part]
      @training_records = TrainingRecord.bring_training_data(@user,@part)
      @data = TrainingRecord.make_chart_data(@training_records)
      respond_to do |format|
        format.json
        format.html { redirect_to user_training_records_path }
      end
    end


  private

  def training_record_params
    params.require(:training_record).permit(:date, :part, :exercise, menus_attributes: [:weight, :rep, :time]).merge(user_id: current_user.id)
  end


end
