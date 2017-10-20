require 'pry'
class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    end
    erb :"/users/create_user"
  end

  post "/signup" do
    if params.has_value?("")
      redirect "/signup"
    end
    @user = User.create(:username => params[:username], email: params[:email], :password => params[:password])
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    end
    erb :"/users/login"
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get "/logout" do
    if logged_in?
  		session.clear
  		redirect "/login"
    else
      redirect "/"
    end
	end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end


  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end


end
