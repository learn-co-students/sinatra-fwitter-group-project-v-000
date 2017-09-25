class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'/users/new'
        else
            redirect '/tweets'
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
        if !logged_in?
            erb :'/users/login'
        else
            redirect "/tweets"
        end

    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get '/logout' do
        if !logged_in?
            redirect "/"
        else
            session.destroy
            redirect "/login"
        end
    end

    get '/users/:id' do
        @user = User.all.find_by_id(params[:id])
        erb :'/users/show'
    end

end
