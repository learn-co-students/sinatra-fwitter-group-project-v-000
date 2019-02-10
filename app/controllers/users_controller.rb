require 'pry'
class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !User.find_by(username: params[:username]) && !params[:username].empty?  && !params[:password].empty? && !params[:email].empty?
      @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = @user.id
    else
      redirect '/signup'
    end

    redirect '/tweets'
  end

  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user.authenticate(params[:password])
      @user = user
      session[:user_id] = @user.id
      binding.pry

      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session[:user_id] = nil
    redirect '/login'
  end

  get '/users/:slug' do
#binding.pry
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'users/show'
  end

end
