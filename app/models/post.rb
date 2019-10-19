class Post < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30}
  validates :description, presence: true, length: { maximum: 140}
end
