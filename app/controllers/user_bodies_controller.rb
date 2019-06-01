class UserBodiesController < ApplicationController

  def new
    @userbody = Userbody.new
  end

  def create
    @userbody = Userbody.new(userbody_params.merge(user_id: current_user.id))

    if @userbody.save
      redirect_to user_path
    else
      render :new
    end
  end

  private

  def userbody_params
    params.require(:user_body).permit(:weight, :height, :gender, :birth_year)
  end

end
