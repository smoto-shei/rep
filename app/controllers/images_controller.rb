class ImagesController < ApplicationController
  before_action :set_user, except: [:create]
  before_action :set_userbody,except: [:create]
  before_action :set_gon_user_id, except: :create
  before_action :set_gon_month, except: :create

  def index
  end

  private

end
