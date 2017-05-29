require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
  	erb :index
  end

  get "/signup" do
    if logged_in?
      redirect to "/tweets"
    end
    erb :'/users/create_user'
  end

  get "/login" do
    if logged_in?
      redirect to "/tweets"
    end
    erb :'/users/login'
  end

  get "/tweets/new" do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    if complete_tweet?
      @tweet.content = params["content"]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get "/tweets" do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/tweets'
  end

  post "/signup" do
    if complete_form?
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  post "/login" do
    if complete_form?
      @user = User.find_by(username: params["username"], password: params["password"])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  post "/tweets" do
    if logged_in? && complete_tweet?
      @tweet = Tweet.create(content: params["content"], user_id: session[:user_id])
    else
      redirect to "/tweets/new"
    end
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
    end
    redirect to "/tweets"
  end

  get "/logout" do
    if logged_in?
      session.clear
		  redirect to "/login"
    else
      redirect to "/"
    end
	end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def complete_form?
      if params["username"] != "" && params["password"] != "" && params["email"] != ""
        true
      else
        false
      end
    end

    def complete_tweet?
      if params["content"] != ""
        true
      else
        false
      end
    end
  end

end
