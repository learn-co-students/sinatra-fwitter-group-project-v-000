class UsersController < ApplicationController

    get '/signup' do
        erb :'/users/signup'
    end

    post '/signup' do
        
        @current_user = User.create(params)
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        @current_user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect to '/tweets/tweets'
    end
      erb :'/login'
    end

    get '/logout' do
        session.clear
        redirect to '/login'
    end

end
