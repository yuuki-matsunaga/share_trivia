class Post < ApplicationRecord

  validates :title, presence: true
  validates :image, presence: true
  validates :genre_id, presence: true
  validates :introduction, presence: true

  attachment :image

  belongs_to :user, optional: true
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :users, through: :goods

  #通知機能
  has_many :notifications, dependent: :destroy

  #いいね順の実装をするためにいいねを一度カウントする
  ransacker :goods_count do
    query = '(SELECT COUNT(goods.post_id) FROM goods where goods.post_id = posts.id GROUP BY goods.post_id)'
    Arel.sql(query)
  end

  #コメント順の実装をする為にコメントを一度カウントする
  ransacker :comments_count do
    query = '(SELECT COUNT(comments.post_id) FROM comments where comments.post_id = posts.id GROUP BY comments.post_id)'
    Arel.sql(query)
  end

  #通知機能（いいね）
  def create_notification_good!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'good'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'good'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  #通知機能（コメント）
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
