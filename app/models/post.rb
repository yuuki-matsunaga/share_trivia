class Post < ApplicationRecord

  attachment :image

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy

  has_many :goods, dependent: :destroy
  has_many :users, through: :goods

end
