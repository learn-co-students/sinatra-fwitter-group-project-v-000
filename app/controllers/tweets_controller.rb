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
    @user = User.find(session[:user_id])
    Tweet.create(content: params[:content], user_id: session[:user_id]).save
  end

end
