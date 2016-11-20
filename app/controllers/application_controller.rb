require './config/environment'
require "pry"
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "time again"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post "/signup" do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:id] = @user.id

      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/tweets/logout" do
    session.clear
    redirect "/"
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get "/tweets" do
    @tweets = Tweet.all
    if logged_in?
      erb :"tweets/tweets"
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
    @tweets = @user.tweets
    erb :"users/tweets"
  end

  get "/tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in? && @tweet
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by(id: params[:id])
#    binding.pry
    if logged_in? && @tweet && current_user.id == session[:id]
      erb :"tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  post "/tweets/:id/edit" do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content] )
      redirect "/tweets"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.destroy
    end

    redirect "/tweets"
  end

  get "/tweets/logout" do
    session.clear
    redirect "/"
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
