class UsersController < ApplicationController
    get '/signup' do 
        erb :'users/signup'
    end

    post '/signup' do 
        params
        redirect to :tweets
    end

    get '/users/login' do 

    end

    post '/login' do 
        params
        session[:user_id]
        redirect to :tweets
    end

    get '/users/logout' do
        session.clear
        redirect to '/'
    end
end
