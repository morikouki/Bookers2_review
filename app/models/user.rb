class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :following, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy
  has_many :following_user, through: :following, source: :follower
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :follower_user, through: :follower, source: :following

  def follow(user_id)
    follower.create(following_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(following_id: user_id).destroy
  end

  def following?(user)
    follower_user.include?(user)
  end


  attachment :profile_image

  validates :name, presence: true,
  				   length: {minimum: 2, maximum: 20}

  validates :introduction, length: {maximum: 50}
end
