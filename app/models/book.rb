class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true,length: {in: 2..100}

  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  belongs_to :user
  scope :favorite_count, -> {includes(:favorites).sort{|a,b| b.favorites.size <=> a.favorites.size}}
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_day_ago, ->(n) {where(created_at: n.day.ago.all_day)}


  scope :created_this_week, -> {where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
  scope :created_last_week, -> {where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day)}


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
