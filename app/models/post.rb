class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments
    has_many :likes, dependent: :destroy
    has_many_attached :images

    scope :newups, -> {order created_at: :desc}
    scope :topups, -> {order views: :desc}
    scope :kups, -> {order views: :desc}    
end