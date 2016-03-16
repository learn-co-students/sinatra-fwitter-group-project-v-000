require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_application_secret"
  end

  get "/" do 
    erb :index
  end

  get "/signup" do 
    if logged_in?
      redirect to "/tweets"
    end
    erb :"/users/create_user"
  end

  post "/signup" do 
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id # log in the user after they sign up
      redirect to "/tweets"
    end
  end

  get "/login" do 
    if logged_in?
      redirect to "/tweets"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get "/logout" do 
    if logged_in?
      session.clear 
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  get "/tweets" do # show all tweets
    @tweets = Tweet.all
    if logged_in?
      @user = current_user
      erb :"/tweets/tweets"      
    else
      redirect to "/login"
    end
  end

  get "/users/:slug" do # show a user
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show_user"
  end

  get "/tweets/new" do # form to create a new tweet
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect to "/login"
    end
  end

  post "/tweets/new" do # create a new tweet
    if params["content"] == ""
      redirect to "/tweets/new"
    else
      @tweet = Tweet.create(content: params["content"], user_id: current_user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get "/tweets/:id" do # show single tweet
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do # form to edit a tweet
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id

      else
        redirect to "/tweets"
      end
    end

  end

  patch "/tweets/:id" do # edit a tweet

  end

  post "/tweets/:id/delete" do # submit delete

  end






  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end


end