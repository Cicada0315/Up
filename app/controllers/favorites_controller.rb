class FavoritesController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    before_action :set_favorite, only: [:show, :update, :edit, :destroy]
    def new
        @favorite = Favorite.new
    end

    def create
        @favorite = current_user.favorites.build(favorite_params)
        if @favorite.save
            redirect_to favorite_path(@favorite)
        else
            render :new
        end    
    end

    def index
        if current_user.favorites.empty?
            flash[:message] = "You don't have any list yet why don't you make one"
            redirect_to new_favorite_path
        else
            @favorites=current_user.favorites
        end
    end

    def edit

    end

    def update
        @favorite.update(favorite_params)

        if @favorite.valid?
            redirect_to favorite_path(@favorite)
        else
            flash[:message] = "Unable to update"
            render :edit
        end
    end

    def show
        
    end

    def destroy
        @favorite.destroy
        redirect_to favorites_path
    end

    private
    def set_favorite
        @favorite=Favorite.find_by(id: params[:id])
    end

    def favorite_params
        params.require(:favorite).permit(:name, :user_id, post_ids: [])
    end
end
