class User < ApplicationRecord
  extend Devise::Models
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def get_profile_image(width, height)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    else
      'default_image.jpg' # デフォルト画像のパス
    end
  end
end

