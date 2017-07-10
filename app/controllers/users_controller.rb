class UsersController < ApplicationController

    get '/signup' do
      if Helper.logged_in?(session)
        redirect to "/tweets"
      else
        erb :'users/create_user'
      end
    end

    post '/signup' do
      if params[:username].empty? || params[:password].empty? || params[:email].empty?
        redirect "/signup"
      else
        user = User.new(username: params[:username], email: params[:email], password: params[:password])
        user.save
        session[:user_id]= user.id
        redirect "/tweets"
      end
    end

    get '/login' do
      if Helper.logged_in?(session)
        redirect to "/tweets"
      else
        erb :'users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id]= @user
        redirect to "/tweets"
      else
        redirect to "/login"
      end
    end

    get '/users/:slug' do
    #  binding.pry
      @user = User.find_by_slug(:slug)
      erb :'users/show'
    end

    get '/logout' do
      session.clear
      redirect to "/login"
    end
end
