class Ranger < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :ranger_icon

  def img_url
    if ranger_icon.present?
      return ranger_icon.image_url
    end

    return "ranger_1.png"
  end
end
