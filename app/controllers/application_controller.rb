class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avator])
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

  def set_gon_user_id
    gon.user_id = current_user.id
  end

end
