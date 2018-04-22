class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = User.find_by(username: session[:username])
      erb :"/tweets/index"
    else
      redirect "/login"
    end
  end

  get '/users/:username' do
    @user = User.find_by(params[:user])
    erb :"/tweets/show"
  end

  get '/tweets/new' do
    @user = User.find_by(params[:user])
    erb :"/tweets/new"
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])
    @tweet.user = User.find_by(username: session[:username])
    @tweet.save
  end


end
