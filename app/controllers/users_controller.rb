class UsersController < ApplicationController

  get '/signup' do
    if !Helpers.is_logged_in?(session)
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if !(params[:username]).empty? && !(params[:email]).empty? && !(params[:password]).empty?
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      redirect to erb :'/tweets/tweets'
    end
  end

  get '/login' do
    if !Helpers.is_logged_in?(session)
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if !@user.nil?
      session[:user_id] = @user.id
      redirect to erb :'/tweets/tweets'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
