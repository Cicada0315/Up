class Favorite < ApplicationRecord
    has_many :favorite_posts
    has_many :posts, through: :favorite_posts
    belongs_to :user
    validates :name, presence: true
end
