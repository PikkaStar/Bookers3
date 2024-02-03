class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true,length: {in: 2..100}

  has_one_attached :image
  belongs_to :user

  def get_image(width,height)
    if image.attached?
      image.variant(resize_to_limit: [width,height]).processed
    else
      "no_image"
    end
  end

end
