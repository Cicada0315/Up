class FavoritesController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    before_action :set_favorite, only: [:show, :update, :edit, :destroy]
    def new
        @favorite = Favorite.new
    end

    def create
        @favorite = current_user.favorites.build(favorite_params)
        if @favorite.save
            redirect_to user_favorite_path(current_user, @favorite)
        else
            render :new
        end    
    end

    def index
        if current_user.favorites.empty?
            flash[:message] = "You don't have any list yet why don't you make one"
            redirect_to new_user_favorite_path(current_user)
        else
            @favorites=current_user.favorites
        end
    end

    def show
        
    end

    private
    def set_favorite
        @favorite=Favorite.find_by(id: params[:id])
    end

    def favorite_params
        params.require(:favorite).permit(:name, :user_id, post_ids: [])
    end
end
