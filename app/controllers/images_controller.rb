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
    @image = Image.find(params[:user_id])
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @image.save
    redirect_back(fallback_location: root_path)
  end

  private

  # 記事投稿のストロングパラメータ
  def image_params
    params.require(:image).permit({user_image: []}).merge(user_id: current_user.id)
  end

  def remove_image_at_index(index)
    remain_images = @image.user_image
     if index == 0 && @image.user_image.size == 1
       @image.remove_user_image!
     else
       deleted_image = remain_images.delete_at(index) 
       deleted_image.try(:remove!)
       @image.user_image = remain_images
     end
  end
  
  def set_image
    @image = Image.find(params[:image_id])
  end

end
