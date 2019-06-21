class ImagesController < ApplicationController
  before_action :set_user, except: [:create]
  before_action :set_userbody,except: [:create]
  before_action :set_gon_user_id, except: :create
  before_action :set_gon_month, except: :create

  # 筋肉画像のページ
  def index
    @user = User.find(params[:user_id])
    @images = Image.where(user_id: params[:user_id])
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    @image.save
    # redirect_back(fallback_location: root_path)
  end

  def edit
    @image = Image.find(1)
  end

  def update
    index = params[:index].strip.split(',').map(&:to_i)
    @image = Image.find(1)
    remove_image_at_index(index)
    binding.pry
    @image.save
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
    params.require(:image).permit(:comment, {user_image: []}).merge(user_id: current_user.id)
  end

  def add_more_images(new_images)
    images = @image.user_image
    images += new_images
    @image.images = images
  end

  def remove_image_at_index(index)
    remain_images = @image.user_image
    index.sort.reverse.each do |i|
      puts |i|
      deleted_image = remain_images.delete_at(i)
      deleted_image.try(:remove!)
    end
    @image.user_image = remain_images
  end
  
  def set_image
    @image = Image.find(params[:image_id])
  end

end
