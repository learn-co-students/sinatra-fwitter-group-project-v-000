require 'pry'

class UsersController < ApplicationController
  get '/signup' do
    if !session[:user_id]
      erb :"users/create_user"
    else
      redirect '/tweets'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    redirect "/tweets/#{user.slug}"
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] ==""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :"/users/login"
    else
      @user = User.find(session[:user_id])
      redirect "/#{@user.slug}/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
