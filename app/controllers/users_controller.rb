require 'pry'
class UsersController < ApplicationController

  get '/users/:slug' do #user index page
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end
  
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


end
