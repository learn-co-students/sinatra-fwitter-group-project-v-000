require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    if logged_in?
      erb :"users/show"
    else
      erb :index
    end
  end

  get "/signup" do
    if logged_in?
      redirect to "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post "/signup" do
    user = User.new(params)

    if user.save
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get "/login" do
    if logged_in?
      redirect to "/tweets"
    else
      erb :"users/login"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get "/logout" do
    if logged_in?
		  session.clear
    end
		redirect to "/login"
	end

  get "/tweets" do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect to "/login"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end
