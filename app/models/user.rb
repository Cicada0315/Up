class User < ApplicationRecord
    has_secure_password
    has_many :uploaded_posts, foreign_key: "user_id", class_name: "Post"
    has_many :comments
    has_many :posts, through: :comments
    validates :password, confirmation: true

    def full_name
        first_name+" "+last_name
    end
end
