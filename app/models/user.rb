class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_one_attached :profile_image
         has_many :books,dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :relationships,class_name: "Relationship",foreign_key: "follower_id"
         has_many :reverse_of_relationships,class_name: "Relationship",foreign_key: "followed_id"
         has_many :followings, through: :relationships, source: :followed
         has_many :followers, through: :reverse_of_relationships,source: :follower
         has_many :groups, through: :group_users
         has_many :group_users, dependent: :destroy
         has_many :entries, dependent: :destroy
         has_many :talks, dependent: :destroy
         has_many :view_counts, dependent: :destroy
         validates :name, presence: true
         validates :introduction, length: {maximum: 100}

         def get_profile_image(width, height)
           if profile_image.attached?
             profile_image.variant(resize_to_limit: [width, height]).processed
           else
             "no_image"
           end
         end

         def follow(user)
           relationships.create(followed_id: user.id)
         end

         def unfollow(user)
           relationships.find_by(followed_id: user.id).destroy
         end

         def following?(user)
           followings.include?(user)
         end
end
