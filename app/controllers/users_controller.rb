require "./app/models/user"
class UsersController < ApplicationController


  get "/signup" do
    erb :"/users/create_user"
  end


  post "/signup" do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    end

    user = User.new(:username => params[:username], :password_digest => params[:password], :email => params[:email])
    if user
      session[:user_id] = user.id
      redirect '/tweets/tweets'
    else
      redirect '/signup'
    end
  end



  get "/login" do
    erb :"/users/login"
  end


  post "/login" do
    user = User.find_by(username: params[:username], email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets/tweets'
    else
      redirect '/users/signup' 
    end
  end


  get "/logout" do
    session.clear
    redirect "/"
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

