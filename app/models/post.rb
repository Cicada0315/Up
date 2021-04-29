class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments
    has_many :likes, dependent: :destroy
    has_many_attached :images

    def like_clicked
        like+=1
    end
    
end