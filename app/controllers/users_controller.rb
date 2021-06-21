class UsersController < ApplicationController
    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        unless params[:username].empty? || params[:email].empty? || params[:password].empty?
            @user = User.create(params)
            session[:user_id] = @user.id 
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/tweets'
        end
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/users/:id' do
        @user = User.find_by_id(params[:id])
         erb :'users/show'
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end
end