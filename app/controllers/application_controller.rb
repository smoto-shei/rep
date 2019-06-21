class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avator])
  end

  private

  # ログイン中のユーザー,ユーザーをセット
  def set_user_info
    @user = User.includes(:user_body).find(current_user.id)
    @userbody = @user.user_body
  end


  # chart.js に渡す user_id をセット
  def set_gon_user_id
    gon.user_id = current_user.id
  end

  # chart.js に渡す x軸 をセット
  def set_gon_month
    mon_array = [0,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5]
    start = (Date.today - 5.month).month                    # スタートは 今月の５ヶ月前
    gon.label = mon_array[start,6].map {|a| a.to_s + '月'}
    gon.label
  end

end
