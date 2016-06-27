class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, presence: true, :on => :create
  validates :password_confirmation, presence: true, :on => :update, :unless => lambda { |user| user.password.blank? }

  has_many :ideas, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :idea

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def full_name
    "#{first_name} #{last_name}"
  end
end
