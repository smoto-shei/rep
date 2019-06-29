class UserBodiesController < ApplicationController

  def new
    @userbody = UserBody.new
  end

  def create
    @userbody = UserBody.new(userbody_params.merge(user_id: current_user.id))
    if @userbody.save
      flash[:success] = 'プロフィールを更新しました'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = '更新に失敗しました'
      render :new
    end
  end

  def update
    if current_user.user_body.update(userbody_params_update)
      flash[:success] = 'プロフィールを更新しました'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = '更新に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def userbody_params
    params.permit(:weight, :height, :gender, :birth_year, :avatar, :experience)
  end

  def userbody_params_update
    params.require(:user_body).permit(:weight, :height, :gender, :birth_year, :avatar, :experience)
  end

end
