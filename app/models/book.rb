class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true,length: {in: 2..100}

  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  scope :favorite_count, -> {self.includes(:favorites).sort{|a,b| b.favorites.size <=> a.favorites.size}}

  def get_image(width,height)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    else
      "no_image"
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
