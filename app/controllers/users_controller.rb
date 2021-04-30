class UsersController < ApplicationController
    def new
        @user = User.new 
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:message] = "Welcome to Up, #{@user.full_name}!"
            session[:user_id] = @user.id
            redirect_to posts_path
        else
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:last_name, :first_name, :username, :email, :password, :password_confirmation)
    end
end
