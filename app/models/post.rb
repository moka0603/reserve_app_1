class Post < ApplicationRecord
  validates :room_name, {presence: true}
  validates :room_introduction, {presence: true}
  validates :room_image, {presence: true}
  validates :price, {presence: true}
  validates :address, {presence: true}
  
  belongs_to :user
  has_many :resers
  
 
end