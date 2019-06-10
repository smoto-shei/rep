class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.where("en_name LIKE :name OR ja_name LIKE :name", name: "%#{params[:keyword]}%").limit(20)
    render json: @exercises
  end
end
