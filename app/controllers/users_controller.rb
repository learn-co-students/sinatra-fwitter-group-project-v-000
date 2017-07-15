class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect to "/tweets"
        else
            erb :"/users/create_user"
        end
    end

    post '/signup' do
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        
        if @user.save
            session[:user_id] = @user.id
            redirect to "/tweets"
        else
            redirect to "/signup"
        end
    end

    get '/login' do
        if logged_in?
            redirect to "/tweets"
        else
            erb :"/users/login"
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/tweets"
        else
            redirect to "/"
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to "/login"
        else
            redirect to "/login"
        end
    end

    get "/users/:slug" do 
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets

        erb :"/users/show"
    end

end