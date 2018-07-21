class UsersController < ApplicationController

  get "/signup" do
    if session.include?("id")
      redirect "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post "/signup" do
    binding.pry
    @user = User.create(params)
    @user.save
    if !User.all.include?(@user)
      redirect "/signup"
    else
      session[:id] = @user.id
      redirect "/tweets"
    end
  end

  get "/tweets" do
    if !!session[:id]
      erb :index
    else
      redirect "/login"
    end
  end

  get "/login" do
    if !!session[:id]
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  helpers do
    def current_user(arg)
      @user = User.find_by(id: arg[:id])
      @user
    end

    def is_logged_in?(arg)
      !!arg[:id]
    end
  end

end
