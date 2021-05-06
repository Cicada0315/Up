class PostsController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_post, only: [:show, :update, :edit, :destroy]
    before_action :find_category, only: [:index, :new, :create]
    def index    
        if @category 
            @posts=@category.posts
        else
            @posts=Post.all
        end
    end

    def mylist
        if current_user.uploaded_posts.empty?
            flash[:message] = "You haven't post anything yet why don't you post one"
            redirect_to new_post_path
        else 
            @posts=current_user.uploaded_posts
        end
        #elsif @category
        #    @posts=[]
        #    @category.posts.each do |p|
        #        if p.user_id==current_user.id
        #            @posts << p
        #        end 
        #    end
        #else
        #    @posts=current_user.uploaded_posts
        #end
    end

    def show
        @post.update(views: @post.views+1)
        @comments = @post.comments
    end

    def new
        if @category
            @post = @category.posts.build
        else
            @post = Post.new
            @post.build_category
        end
    end
    
    def create
        @post = Post.new(post_params)
        @post.image.attach(params[:post][:image])
        
        if @post.save
            if @category
                redirect_to category_posts_path(@category)
            else
                redirect_to post_path(@post)
            end
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
        params.require(:post).permit(:user_id, :title, :link, :content, :image, :category_id, category_attributes: [:name])
    end

    def find_category
        @category = Category.find_by_id(params[:category_id])
    end
end
