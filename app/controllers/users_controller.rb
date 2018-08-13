require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect "/show/#{@user.id}"
    else
      flash[:message] = "Sorry, username and password do not match."
      redirect "/login"
    end
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.new(params)
    @user.save
    redirect "/login"
  end

  get '/show/:id' do
    if logged_in?
      @current_user = current_user
      erb :'/users/show'
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

end
