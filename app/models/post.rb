class Post < ApplicationRecord

  validates :title, presence: true
  validates :image, presence: true
  validates :genre_id, presence: true
  validates :introduction, presence: true

  attachment :image

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy

  has_many :goods, dependent: :destroy
  has_many :users, through: :goods

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

end
