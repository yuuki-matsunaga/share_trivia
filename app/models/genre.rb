class Genre < ApplicationRecord

  validates :name, length: {minimum: 1, maximum: 10}
  has_many :posts, dependent: :destroy


end
