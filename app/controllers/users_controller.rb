class UsersController < ApplicationController
    
    get '/signup' do 
        if !logged_in?
            erb :"users/signup"
        else
            redirect "/tweets"
        end
    end
    
    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect "/signup"
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/tweets"
        end
    end
    
    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :"/users/login"
        end
    end

    get '/logout' do
        if logged_in?
            logout!
            redirect "/login"
        else
            redirect "/"
        end
    end
    
    post '/login' do
    
        if params[:username] == "" || params[:password] == ""
            redirect '/login'
        else
            @user = User.find_by(username: params[:username])
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect '/tweets'
            else
                redirect '/login'
            end
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"users/index"
    end
    
    
    
end