class ExercisesController < ApplicationController

  # カレンダーページ、トレーニングのインクリメンタルサーチ
  def index
    @exercises = Exercise.where("en_name LIKE :name OR ja_name LIKE :name", name: "%#{params[:keyword]}%").limit(10)
    render json: @exercises
  end

end

