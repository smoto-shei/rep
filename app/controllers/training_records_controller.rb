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
      @part, @unit = for_graph_params[:part],for_graph_params[:unit]
      @training_records = TrainingRecord.bring_training_data(@user,@part)
      if @unit == 'month'
        @x_label = set_month
        @data = TrainingRecord.make_data_for_month(@training_records)
      else
        @x_label = set_week
        @data = TrainingRecord.make_data_for_week(@training_records)
      end
      respond_to do |format|
        format.json
        format.html { redirect_to user_training_records_path }
      end
    end


  private

  def training_record_params
    params.require(:training_record).permit(:date, :part, :exercise, menus_attributes: [:weight, :rep, :time]).merge(user_id: current_user.id)
  end

  def for_graph_params
    params.permit(:part,:unit)
  end

  def set_month
    @mon = Date.today.month
    gon.label = (@mon-5..@mon).to_a.map {|a| a.to_s + '月'}
    return gon.label
  end

  def set_week
    gon.label = ['５週間前','４週間前','３週間前','２週間前','先週','今週']
    return gon.label
  end

  #----------------------------------------------------- ApplicationControllerに記述
  # def set_user
  #   @user = User.find(current_user.id)
  # end

  # def set_userbody
  #   @userbody = @user.user_body
  # end

  # def set_gon_user_id
  #   gon.user_id = current_user.id
  # end


end
