class ImagesController < ApplicationController
  before_action :set_user_info, except: [:create]
  before_action :set_gon_user_id, except: :create
  before_action :set_gon_month, except: :create

  # 筋肉画像のページ
  def index
  end

end
