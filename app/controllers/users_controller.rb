class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect to "/tweets"
    end

  end

  post '/signup' do
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect to '/signup'
      else

        @user = User.new
        @user.username = params[:username]
        @user.email = params[:email]
        @user.password = params[:password]
        @user.save
        session[:user_id] = @user.id
        redirect to '/tweets'
      end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      erb :'tweets/tweets'

    end

  end

  post '/login' do

    @user = User.find_by(username: params[:username])
    # binding.pry
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      current_user
      
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end




end
