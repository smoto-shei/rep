class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :training_records, dependent: :destroy
  has_many :images, dependent: :destroy

  # @user.relationships で relationshipsテーブル[:user_id]==@user.id を取ってくる。classはrelationships。
  # user_id,follow_id しか持っていない。これを次のfollowsに渡し名前などの情報を得る。
  has_many :relationships #, foreign_key: user_id
  # @User.follows でrerationships[:user_id]==@user.id を取る.relationshipsテーブルを参照し、またそのfollow_idカラム(下follow_id ではだめだった)を参照する。classはUser。
  has_many :follows, through: :relationships, source: :follow

  # @user.reverse_of_relationships で follow_id==@user.id を取ってくる。class_nameを指定する必要あり。
  # user_id,follow_id しか持っていない。これを次のfollowesに渡し名前などの情報を得る。
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # @user.followers で relationships[:follow_id]==@user.idを取ってくる
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_one :user_body

  # フォローする
  def follow(searched_user)
    unless self == searched_user
      self.relationships.find_or_create_by(follow_id: searched_user.id)
    end
  end

  # フォロー解除
  def unfollow(searched_user)
    relationship = self.relationships.find_by(follow_id: searched_user.id)
    relationship.destroy if relationship
  end

  # フォロー済みかどうかを調べる
  def following?(searched_user)
    self.follows.include?(searched_user) #follows はフォローをしているuser
  end

  # integer型をdate型に変換する
  def self.search_experience(params)

    start_p = params[:user_body_experience_lteq]
    fin_p = params[:user_body_experience_gteq]

    if start_p.class == String && fin_p.class == String
      # lteq は <= (less than equal)
      unless start_p == ""
        a = start_p.to_i
        start = (Date.today - a.year).beginning_of_month
        params[:user_body_experience_lteq] = start + 1.year
      end
      # gteq は >= (greater than equal)
      unless fin_p == ""
        z =fin_p.to_i
        # 数字をdate型に戻す
        fin =  (Date.today - z.year) + 1.month
        params[:user_body_experience_gteq] = fin
      end
    end

    return params
  end

end
