class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @training_records = @user.training_records
    @userbody = @user.user_body
  end

end
