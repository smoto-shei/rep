class TrainingRecordsController < ApplicationController



    # Analysisページ
    def index
      @user = User.includes(:user_body, :follows, :followers).find(params[:user_id])
      @userbody = @user.user_body
      @follows = @user.follows.page(params[:page]).per(5)
      @followers = @user.followers.page(params[:page]).per(5)
    end

    # Analysisページ グラフ描写。
    def draw_graph
      @user, @part, @unit = User.find(graph_params[:user_id]), graph_params[:part], graph_params[:unit]
      @training_records = TrainingRecord.bring_training_data(@user,@part)

      if @unit == 'month'
        @x_label = TrainingRecord.set_month
        @data = TrainingRecord.make_data_for_month(@training_records)
      else
        @x_label = TrainingRecord.set_week
        @data = TrainingRecord.make_data_for_week(@training_records)
      end


      respond_to do |format|
        format.json
        format.html { redirect_to user_training_records_path }
      end
    end

    # トレーニングレコードの登録
    def create
      @training_record = TrainingRecord.new(training_record_params)
      @training_records = TrainingRecord.where(user_id: current_user.id, date: params[:training_record][:date])
      @user = User.find(current_user.id)
      unless @training_record.save
        render status: 400, body: nil
      end
    end

    # カレンダーページ、レコード削除
    def destroy
      @training_record = TrainingRecord.find_by(id: params[:id])
      if current_user.id == @training_record.user_id
        date = @training_record.date
        @training_record.destroy
        @training_records = TrainingRecord.where(user_id: params[:user_id], date: date)
        render partial: "shared/day_records_on_calendar", locals: { training_records: @training_records }
      end
    end


  private

  # トレーニングレコードを登録するときのパラメータ
  def training_record_params
    params.require(:training_record).permit(:date, :part, :exercise, menus_attributes: [:weight, :rep, :time]).merge(user_id: current_user.id)
  end

  # グラフページのラジオボタンの checked のパラメータ
  def graph_params
    params.permit(:part, :unit, :user_id)
  end

end
