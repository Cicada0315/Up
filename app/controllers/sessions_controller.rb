class SessionsController < ApplicationController
    def new
        @user=User.new
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

    def omniauth
        #request.env['omniauth.auth']
        @user=User.find_or_create_by(email: auth[:info][:email]) do |u|
            u.email=auth[:info][:email]
            u.username=auth[:info][:name]
            u.first_name=auth[:info][:first_name]
            u.last_name=auth[:info][:last_name]
            u.uid=auth[:uid]
            u.provider=auth[:provider]
            u.password = SecureRandom.hex(10)
        end
        flash[:message] = "Welcome to Up, #{@user.full_name}!"
        session[:user_id] = @user.id
        redirect_to posts_path
        #not working maybe password confirmation.. 
        #if @user.valid?
        #    flash[:message] = "Welcome to Up, #{@user.full_name}!"
        #    session[:user_id] = @user.id
        #    redirect_to posts_path
        #else
        #    flash[:message] = "log in fail"
        #    render :new
        #end
    end
    
    private 
    def auth
        request.env['omniauth.auth']
    end
end
