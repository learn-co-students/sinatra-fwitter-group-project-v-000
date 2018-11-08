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
    erb :'users/login'
  end

  post '/login' do
    # raise params.inspect
    @user = User.find_by(params[:user_id])
    redirect to '/tweets'

  end




end
