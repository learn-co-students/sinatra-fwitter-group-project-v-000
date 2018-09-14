class UsersController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

    get '/signup' do
      if !!session[:id]
        redirect to '/tweets'
      else
        erb :'/users/create_user'
      end
    end

    post '/signup' do
      @user = User.find_or_create_by(email: params[:email])
      @user.username = params[:username]
      @user.password = params[:password]
      if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect to '/signup'
      else
        @user.save
        session[:id] = @user.id
        redirect to '/tweets'
      end
    end

    get '/login' do
      erb :'/users/login'
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect '/signup'
      end
    end


end
