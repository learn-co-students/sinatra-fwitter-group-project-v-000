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
    erb :'/users/signup'
  end

  post "/signup" do
    if !logged_in?
      @user = User.create(params)
      if @user.username == "" || @user.email == "" || @user.password == ""
        redirect('/signup')
      else
        session[:user_id] = @user.id
        redirect("/tweets")
      end
    else
      redirect("/tweets")
    end
  end

  get "/tweets" do
  end


  helpers do

    def logged_in?
      if session[:user_id]
        return user
      else
        return false
      end
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
