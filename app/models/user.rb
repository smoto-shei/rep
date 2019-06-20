class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :training_records, dependent: :destroy
  has_many :images, dependent: :destroy
  has_one :user_body

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

    else

      unless start_p == ""
        start = ((Date.today.year - start_p.year)*12 + (Date.today.month - start_p.month)) / 12 + 1
        params[:user_body_experience_lteq] = start
      end

      unless fin_p == ""
        fin = ((Date.today.year - fin_p.year)*12 + (Date.today.month - fin_p.month)) / 12 + 1
        params[:user_body_experience_gteq] = fin
      end

    end

    return params
  end

  # def reset_experience


end
