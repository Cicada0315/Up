class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :find_post
    def create
        @comment = @post.comments.build(comment_params)
        if @comment.save
            flash[:message] = "You Commented this post"
            redirect_to post_path(@post)
        else
            flash[:message] = "Something went wrong, try again"
            redirect_to post_path(@post)
        end

    end

    private
    def find_post
        @post = Post.find_by(id: params[:post_id])
    end

    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :content)
    end
end