class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  validates :name, length: {minimum: 1, maximum: 10}
  validates :comment, length:{minimum: 0, maximum: 200}
  validates :name, presence: true
  validates :image, presence: true

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :good_posts, through: :goods, source: :post

  #通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy #自分からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy #相手からの通知

  #フォロー機能
  # 被フォロー関係を通じて参照→followed_idをフォローしている人
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #foreign_key: "followed_id"でどのカラムを参照して欲しいのかを定義する
  has_many :followers, through: :reverse_of_relationships, source: :follower
  #reverse_of_relationshipsモデルをthroughしてfollower(_id)というカラムを参照(source)する
  #フォロー・フォロワー一覧ページを作成する時@user.followersを使用したい為

  #フォロワー機能(同上)
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def own?(object)
    id == object.user_id
  end

  #いいね機能

  def good(post)
    goods.find_or_create_by(post: post)
  end

  def good?(post)
    good_posts.include?(post)
  end

  def ungood(post)
    good_posts.delete(post)
  end

  #通知機能（フォロー）

  #----------フォロー機能重複して通知がいかないようにする記述をコメントアウトしてます---------------------

  def create_notification_follow!(current_user)
    # temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])

    # if true
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    # end
  end

end
