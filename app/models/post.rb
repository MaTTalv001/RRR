# app/models/post.rb
class Post < ApplicationRecord
  has_one_attached :image
  before_save :set_default_name
  validates :body, length: { maximum: 50 }

  
  validates :body, presence: true
  validates :category, presence: true
  validates :name, presence: true

  private

  def set_default_name
    self.name = "名無し" if name.blank?
  end
end