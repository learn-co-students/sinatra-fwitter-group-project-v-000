class UsersController < ApplicationController

  get '/signup' do
    if !Helpers.is_logged_in?(session)
      erb :'/users/create_user'
    else
      erb :'/tweets'
    end
  end

  post '/signup' do
    if !(params[:username]).empty? && !(params[:email]).empty? && !(params[:password]).empty?
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      redirect to '/tweets'
    else
      redirect to '/'
    end
  end

  get '/login' do
    if !Helpers.is_logged_in?(session)
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  get '/tweets' do
    @user = User.find_by(username: params["username"])
    erb :'/users/show'
  end
end
