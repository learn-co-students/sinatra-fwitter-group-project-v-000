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
      @user = current_user
      @tweets = current_user.tweets
      erb :"users/show"
    else
      erb :index
    end
  end

  # ----- REGISTRATION & SESSIONS -----

  get "/signup" do
    if logged_in?
      redirect to "/tweets"
    else
      erb :signup
    end
  end

  post "/signup" do
    user = User.new(params)

    if user.save
      session[:user_id] = user.id
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

  # ----- TWEETS -----
  get "/tweets" do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect to "/login"
    end
  end

  post "/tweets" do
    if !params[:content].empty?
      current_user.tweets.create(params)
      redirect to "/tweets"
    else
      redirect to "/tweets/new"
    end
  end

  get "/tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in?
      erb :"tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in? && current_user.tweets.include?(@tweet)
      erb :"tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  post "/tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])

    if !params[:content].empty?
      @tweet.update(params)
      erb :"tweets/show_tweet"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  post "/tweets/:id/delete" do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in? && current_user.tweets.include?(@tweet)
      Tweet.find_by(id: params[:id]).destroy
      redirect to "/tweets"
    else
      redirect to "/tweets"
    end

  end

  # ----- USERS -----

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    @tweets = current_user.tweets
    erb :"users/show"
  end

  # ----- HELPERS -----

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end
