class Good < ApplicationRecord

  belongs_to :post
  belongs_to :user

  def own?(object)
    id == object.user_id
  end

  def good(post)
    goods.find_or_create_by(post: post)
  end
  
#ユーザーがすでにその投稿に「いいね！」しているかを判別するメソッド
  def good?(post)
    good_posts.include?(post)
  end

  def ungood(post)
    good_posts.delete(post)
  end

end
