class TweetsController < ApplicationController
  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    @tweet = Tweet.new
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    @user = current_user
    @tweet = Tweet.new params
    if @tweet.save
      @user.tweets << @tweet
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = @tweet.errors.full_messages.uniq
      redirect '/tweets/new'
    end
  end
end
