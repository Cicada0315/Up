class PostsController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:index, :new, :create, :edit, :update, :destroy]
    before_action :set_post, only: [:show, :update, :edit, :destroy]
    def index
        if current_user.uploaded_posts.empty?
            flash[:message] = "You haven't post anything yet why don't you post one"
            redirect_to new_post_path
        else
            @posts=current_user.uploaded_posts
        end
    end

    def show
        @post.update(views: @post.views+1)
        @comments = @post.comments
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.image.attach(params[:post][:image])
        
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

    def destroy
        @post.destroy
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

    def search
        @posts = Post.search(params[:title])
        render :index
    end

    private
    def set_post
        @post=Post.find_by(id: params[:id])
    end

    def post_params
        params.require(:post).permit(:user_id, :title, :link, :content, :image)
    end
end
