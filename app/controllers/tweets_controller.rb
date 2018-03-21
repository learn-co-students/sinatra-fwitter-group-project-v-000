class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if user = User.find_by_id(session[:user_id])
      if user.tweets << Tweet.new(content: params[:content])
        tweet = user.tweets.last
        redirect to :"/tweets/#{tweet.id}"
      end
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      user = User.find_by_id(session[:user_id])
      if user.tweets.include?(@tweet)
        erb :'/tweets/show_tweet'
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:id])
      if user.tweets.include?(@tweet)
        erb :'tweets/edit_tweet'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      tweet = Tweet.find_by_id(params[:id])
      if i = user.tweets.find_index(tweet)
        user.tweets[i].content = params[:content]
        @tweet = user.tweets[i]
        if @tweet.save
          erb :'tweets/show_tweet'
        else
          redirect to "/tweets/#{params[:id]}/edit"
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      tweet = Tweet.find_by_id(params[:id])
      if i = user.tweets.find_index(tweet)
        user.tweets[i].delete
        redirect to '/tweets'
      end
    else
      redirect to 'login'
    end
  end
end
