class UserBodiesController < ApplicationController


  def new
    binding.pry
    @userbody = UserBody.new
  end

  def create
    @userbody = UserBody.new(userbody_params.merge(user_id: current_user.id))

    if @userbody.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def update
    if current_user.user_body.update(userbody_params_update)
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  private


  def userbody_params
    params.permit(:weight, :height, :gender, :birth_year, :avatar)
  end

  def userbody_params_update
    params.require(:user_body).permit(:weight, :height, :gender, :birth_year, :avatar)
  end

end
