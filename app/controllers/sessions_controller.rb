class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
            flash[:message] = "Welcome to Up, #{@user.full_name}!"
            session[:user_id] = @user.id
            redirect_to posts_path
        else
            flash[:message] = "Invalid Credentials"
            render :new
        end
    end

    def destroy
        session.clear
        redirect_to login_path
    end
end
