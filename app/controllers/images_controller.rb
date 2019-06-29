class ImagesController < ApplicationController
  before_action :set_image, only: [:edit, :update, :destroy]

  # 筋肉画像のページ
  def index
    @user = User.includes(:user_body, :follows, :followers).find(params[:user_id])
    @userbody = @user.user_body
    @follows = @user.follows
    @followers = @user.followers
    @images = Image.where(user_id: params[:user_id])
                   .order(created_at: :desc).page(params[:page]).per(5)
    @image = Image.new
  end

  # 画像記事の投稿
  def create
    @image = Image.new(image_params)
    @image.save
  end

  # 画像記事のコメントの編集フォームをモーダル表示
  def edit
    render partial: "shared/edit_comment", locals: { image: @image }
  end

  # 画像記事のコメントを編集
  def update
    @image.update(image_params)
    redirect_back(fallback_location: root_path)
  end

  # 画像記事の削除
  def destroy
    if current_user.id == @image.user_id
      @image.destroy
    end
    redirect_back(fallback_location: root_path)
  end

  private

  # 画像のセット
  def set_image
    @image = Image.find(params[:id])
  end
  # 記事投稿のストロングパラメータ
  def image_params
    params.require(:image).permit(:comment, {user_image: []}).merge(user_id: current_user.id)
  end

  # # 記事に画像を個別追加
  # def add_more_images(new_images)
  #   images = @image.user_image
  #   images += new_images
  #   @image.images = images
  # end

  # # 記事内の画像の個別削除
  # def remove_image_at_index(index)
  #   remain_images = @image.user_image
  #   index.sort.reverse.each do |i|
  #     deleted_image = remain_images.delete_at(i)
  #     deleted_image.try(:remove!)
  #   end
  #   @image.user_image = remain_images
  # end

end
