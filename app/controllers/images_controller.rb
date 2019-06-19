class ImagesController < ApplicationController
  before_action :set_user, except: [:create]
  before_action :set_userbody,except: [:create]
  before_action :set_gon_user_id, except: :create
  before_action :set_gon_month, except: :create

  # 筋肉画像のページ
  def index
    @images = Image.where(user_id: params[:user_id])
    @image = Image.new
  end

  def create
    @images = Image.new(image_params)
    @images.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # 記事投稿のストロングパラメータ
  def image_params
    params.require(:image).permit({user_image: []}).merge(user_id: current_user.id)
  end
end
