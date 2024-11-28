# app/models/post.rb
class Post < ApplicationRecord
  has_one_attached :image
  
  validates :body, presence: true
  validates :category, presence: true
  validates :name, presence: true
end