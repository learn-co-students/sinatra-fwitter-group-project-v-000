class TweetController < ApplicationController
  include Authable::InstanceMethods
  include Ownable::InstanceMethods

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content])
    if logged_in? && tweet.valid?
      current_user.tweets << tweet
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user_owns(tweet) && !params[:content].empty?
      tweet.update(content: params[:content])
      redirect '/tweets'
    elsif logged_in? && current_user_owns(tweet) && params[:content].empty?
      redirect "/tweets/#{tweet.id}/edit"
    elsif logged_in?
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user_owns(tweet)
      Tweet.destroy(tweet.id)
      redirect '/tweets'
    elsif logged_in?
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
