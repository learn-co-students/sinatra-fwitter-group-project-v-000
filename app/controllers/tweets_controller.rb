class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      erb :'tweets/tweets_index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_id(session[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_id(session[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].size > 0
      @user = User.find_by_id(session[:id])
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      erb :'tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  post '/tweets/:id' do
    binding.pry
    redirect "tweets/#{session[:id]}"
  end

  post '/tweets/:id/delete' do
    binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect to "tweets/#{session[:id]}"
  end

end
