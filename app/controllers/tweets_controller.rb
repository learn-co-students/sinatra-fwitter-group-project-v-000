class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if session[:user_id]
      if params[:content].empty?
        redirect "/tweets/new"
      else
        @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
        @tweet.save
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

end