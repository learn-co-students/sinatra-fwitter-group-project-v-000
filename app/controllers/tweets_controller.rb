class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      erb :'tweets/new'
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @user = User.find(session[:user_id])
      Tweet.create(content: params[:content], user_id: session[:user_id]).save
    end
  end

  get '/tweets/:id' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @users_tweet = User.find(session[:user_id]).tweets.find(params[:id]).content
      erb :'tweets/show_tweet'
    end
  end


end
