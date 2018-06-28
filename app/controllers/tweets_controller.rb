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
    binding.pry
    if !logged_in?
      redirect to("/login")
    else
      @tweet = Tweet.find_by(id: params[:tweet_id])
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:tweet_id/edit' do
    binding.pry
    if !logged_in?
      redirect to("/login")
    else
      @tweet = Tweet.find_by(id: params[:tweet_id])
      if @tweet.user_id == current_user.id
        erb :'tweets/edit_tweet'
      else
        redirect to("/login")
      end
    end
  end

  patch '/tweets/:tweet_id' do
    binding.pry
    @tweet = Tweet.find_by(id: params[:tweet_id])
    if params[:content] == ""
      redirect to("tweets/#{@tweet.id}/edit")
    else
      @tweet.update(content: params[:content])
      @tweet.save
      redirect to("/tweets/#{@tweet.id}")
    end
  end


end
