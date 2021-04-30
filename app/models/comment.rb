class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    validates :content, presence: true

    def comment_date
        created_at.strftime("%m. %d. %Y")
    end
end
