require 'pry'
class UsersController < ApplicationController
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :"/users/home"
  end

  get "/signup" do
    if logged_in?
      redirect("/tweets")
    else
      erb :'/users/signup'
    end
  end

  post "/signup" do
    @user = User.create(params)
    if @user.username == "" || @user.email == "" || @user.password == ""
      redirect('/signup')
    else
      session[:user_id] = @user.id
      redirect("/tweets")
    end
  end

  get '/login' do
    if logged_in?
      redirect('/tweets')
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect('/tweets')
    else
      redirect ('/login')
    end
  end

  get "/tweets" do
    @user = current_user
    erb :'/users/tweets'
  end


  helpers do

    def logged_in?
      if session[:user_id]
        return self
      else
        return false
      end
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
