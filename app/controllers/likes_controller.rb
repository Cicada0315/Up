class LikesController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :find_post  
    def create
        if @post.user_id == current_user.id
            flash[:message] = "You can't like this posts since you uploaded it"  
        elsif already_liked?
            flash[:message] = "You can't like more than once"
        else
            @post.likes.create(user_id: current_user.id)
        end
        redirect_to post_path(@post)
    end  

    private  
    def find_post
        @post = Post.find_by(id: params[:post_id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end
end
