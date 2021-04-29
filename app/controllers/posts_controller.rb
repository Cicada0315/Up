class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :edit, :destory]
    def index
        @posts=current_user.uploaded_posts
    end

    def show
        @post.update(views: @post.views+1)
        @comments = @post.comments
        #@comment = @post.comments.build(user_id: current_user.id)
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.images.attach(params[:post][:images])
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

    def topups
        @posts=Post.topups
    end

    def kups
        @posts=Post.kups
    end

    def newups
        @posts=Post.newups
    end

    private
    def set_post
        @post=Post.find_by(id: params[:id])
    end

    def post_params
        params.require(:post).permit(:user_id, :title, :link, :content)
    end
end
