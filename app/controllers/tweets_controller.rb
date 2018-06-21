class TweetsController < ApplicationController

  get '/tweets' do
    if !!logged_in?
     redirect "/login"
    else
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect "/users/login"
    end
  end

  post '/tweet' do
    @tweet = tweet.new(content: params[:content])
    if !params[:content].empty?
      tweet = tweet.create(content: params[:content])
      current.user.tweets << tweet
      current_user.save
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    @user = current_user
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end



end
