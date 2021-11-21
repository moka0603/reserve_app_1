class User < ApplicationRecord
  has_secure_password validations: true
  validates :password, length: { minimum: 8 }, if: Proc.new { |user| user.password.present? }
  validates :name, {presence: true, length: { maximum: 14 }}
  validates :email, {presence: true, uniqueness: true}
  has_many :posts
  has_many :resers
end
