class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :users, through: :comments
    has_many :likes, dependent: :destroy
    has_many_attached :images

    scope :newups, -> {order created_at: :desc}
    scope :topups, -> {order views: :desc}
    scope :kups, -> { 
        select('posts.*, COUNT(likes.post_id) AS likes_count')
        .joins(:likes)
        .group('post_id')
        .order('likes_count DESC')
    }
    
    def post_date
        created_at.strftime("%m/%d/%Y")
    end
end