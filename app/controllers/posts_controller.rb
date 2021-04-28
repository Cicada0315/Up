class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :edit, :destory]
    def index
        @posts=Post.all
    end

    def show
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to post_path(@post)
        else
            render :new
        end
    end

    def edit
    end

    def update
        @post.update(post_params)
        if @post.valid?
            redirect_to post_path(@post)
        else
            render :edit
        end
    end

    def destory
        @post.destory
        redirect_to posts_path
    end

    private
    def set_post
        @post=Post.find_by(id: params[:id])
    end

    def post_params
        params.require(:post).permit(:user_id, :title, :image, :clip, :link, :content)
    end
end
