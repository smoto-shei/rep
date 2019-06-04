class TrainingRecordsController < ApplicationController

  def index
    # @records = User.find(current_user.id).trainig_records
    @user = User.find(current_user.id)
    @training_records = @user.training_records
    @userbody = @user.user_body
  end

end
