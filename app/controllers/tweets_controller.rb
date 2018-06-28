class TweetsController < ApplicationController

  get '/tweets' do
    binding.pry
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect to("/login")
    end
  end

  get '/tweets/new' do
    binding.pry
    if !logged_in?
      redirect to("/login")
    else
      @user = current_user
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets' do
    binding.pry
    if params[:content] == ""
      redirect to("/tweets/new")
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    end
  end

  get '/tweets/:tweet_id' do

  end


end
