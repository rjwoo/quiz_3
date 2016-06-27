class Idea < ActiveRecord::Base

  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :comments, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by_user_id(user)
  end
end
