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
    erb :"users/create_user"
  end

  post "/signup" do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id

      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/tweets/new" do
    erb :"tweets/create_tweet"
  end

  post "/tweets" do
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    redirect "/tweets"
  end

  get "/tweets" do
    erb :"tweets/tweets"
  end

end
