class UserController < ApplicationController

  get '/signup' do
    erb :"/users/create_user" unless logged_in?
    # if !logged_in?
    #   erb :'/users/create_user'
    # else
    #   erb :"/tweets"
    # end
  end

  post '/signup' do
    #binding.pry
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.create(params[:user])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
     if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect to "/tweets"
     else
       redirect "/login"
     end
  end

  get '/logout' do
    session.clear
    erb :'/index'
  end

end
