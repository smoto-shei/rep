class UsersController < ApplicationController

  # ユーザー検索画面
  def index
    @user = User.includes(:user_body, :follows, :followers).find(current_user.id)
    @userbody = @user.user_body
    @follows = @user.follows
    @followers = @user.followers
    if params[:q].present?
      gon.formdata = search_params
      @params = User.search_experience(search_params)
    end
    @search = User.ransack(@params)
    @people = @search.result(nickname_present: 1).includes(:user_body).page(params[:page]).per(5).order("user_bodies.experience asc")
  end

  # カレンダーページ（マイページ）
  def show
    @user = User.includes(:user_body, :follows, :followers).find(params[:id])
    @userbody = @user.user_body
    @follows = @user.follows.page(params[:page]).per(5)
    @followers = @user.followers.page(params[:page]).per(5)


    @training_records = @user.training_records.includes(:menus)
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

  private
  # ユーザー検索のparams
  def search_params
    params.require(:q).permit(:nickname_start, :user_body_height_gteq, :user_body_height_lteq,
                              :user_body_weight_gteq, :user_body_weight_lteq, :user_body_experience_gteq,
                              :user_body_experience_lteq, :test)
  end

end
