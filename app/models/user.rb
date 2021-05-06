class User < ApplicationRecord
    has_secure_password
    has_many :favorites
    has_many :uploaded_posts, foreign_key: "user_id", class_name: "Post"
    has_many :comments
    has_many :posts, through: :comments
    
    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, confirmation: true 

    def full_name
        first_name+" "+last_name
    end
end
