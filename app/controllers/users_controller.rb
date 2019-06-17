class UsersController < ApplicationController
  before_action :set_user, except: [:create]
  before_action :set_userbody,except: [:create]
  before_action :set_gon_month, except: :create    #turbolinks で読み込まれるためアクション前にセット
  before_action :set_gon_user_id, except: :create  #turbolinks で読み込まれるためアクション前にセット

  # ユーザー検索画面
  def index
    @search = User.ransack(params[:q])
    @people = @search.result.includes(:user_body)
  end

  # カレンダーページ（マイページ）
  def show
    @user = User.find(params[:id])
    @training_records = @user.training_records.includes(:menus)
    @userbody = @user.user_body
    @training_record =  TrainingRecord.new
    @training_record.menus.build
    @day_records = @training_records.where(date: Date.today )
  end

  # カレンダーページの実施したメニューの更新
  def records_update
    @day_records = TrainingRecord.where(user_id: params[:id], date: params[:date]).includes(:menus)
    @user = User.find(params[:id])
    render partial: "shared/training_records", collection: @day_records, as: "day_record"
  end

end
