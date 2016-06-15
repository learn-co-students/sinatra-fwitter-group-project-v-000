class TweetsController < ApplicationController

  get '/tweets' do
    # "hello world"
    if !session[:user_id]
      redirect to '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !session[:user_id]
      redirect to '/login'
    else
      erb :'/tweets/create_tweet'
    end  end

  post '/tweets' do
    # "hello world"
    if !params[:content].empty?
      tweet = Tweet.create(content: params[:content])
      tweet.user_id = session[:user_id]
      tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

end


