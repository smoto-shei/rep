class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @training_records = @user.training_records
  end

end
