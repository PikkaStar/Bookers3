class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  belongs_to :owner, class_name: 'User'
  has_one_attached :group_image

  def get_group_image(width, height)
    if group_image.attached?
      group_image.variant(resize_to_limit: [width,height]).processed
    else
      "no_image"
    end
  end

  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

  def is_owned_by?(user)
    user == owner
  end

end
