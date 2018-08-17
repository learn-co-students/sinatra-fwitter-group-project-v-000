require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "tweets"
    else
      flash[:message] = "Sorry, username and password do not match."
      redirect "/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.username != "" && @user.email != "" && !!@user.save
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/show/:id' do
    if logged_in? && current_user.id == params[:id].to_i
      @current_user = current_user
      erb :'/users/show'
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

end
