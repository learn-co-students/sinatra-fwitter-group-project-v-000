class UsersController < ApplicationController
    get '/signup' do 
        erb :'users/new'
    end

    post '/signup' do 
        user = User.create(params)
        session[:user_id] = user.id
        redirect to :tweets
    end

    get '/login' do 
        erb :'users/login'
    end

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/'
        end
    end

    get '/users/logout' do
        session.clear
        redirect to '/'
    end
end
