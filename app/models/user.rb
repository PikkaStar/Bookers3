class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_one_attached :profile_image
         validates :name, presence: true
         validates :introduction, length: {maximum: 100}

         def get_profile_image(width, height)
           if profile_image.attached?
             profile_image.variant(resize_to_limit: [width, height]).processed
           else
             "no_image"
           end
         end
end