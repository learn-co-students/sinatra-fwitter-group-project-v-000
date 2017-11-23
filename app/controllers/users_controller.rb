require './config/environment'
class UsersController < ApplicationController

  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    u ||= User.new(params)
    if !u.username.empty? && !u.email.empty? && u.password_digest
      u.save
      session[:user_id] = u.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:user' do
    @tweets = Tweet.all
    erb :show_tweet.erb
  end
end
