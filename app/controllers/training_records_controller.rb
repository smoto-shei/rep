class TrainingRecordsController < ApplicationController
  before_action :set_user_info, except: [:create, :index]
  before_action :set_gon_month, except: :create    #turbolinks で読み込まれるためアクション前にセット
  before_action :set_gon_user_id, except: :create  #turbolinks で読み込まれるためアクション前にセット



    # Analysisページ
    def index
      @user = User.includes(:user_body, :follows, :followers).find(params[:user_id])
      @userbody = @user.user_body
      @follows = @user.follows.page(params[:page]).per(5)
      @followers = @user.followers.page(params[:page]).per(5)
    end

    # Analysisページ グラフ描写
    def draw_graph
      @part, @unit = graph_radio_btn_params[:part], graph_radio_btn_params[:unit]
      @training_records = TrainingRecord.bring_training_data(@user,@part)
      gon.user_id = params[:user_id]
      if @unit == 'month'
        @x_label = set_gon_month
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
  def graph_radio_btn_params
    params.permit(:part,:unit)
  end

  # グラフのx軸を週にセット
  def set_week
    gon.label = ['５週間前','４週間前','３週間前','２週間前','先週','今週']
    gon.label
  end

end
