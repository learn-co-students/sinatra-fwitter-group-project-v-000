class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :"/tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !!params["content"] && params["content"] != ""
      @tweet = Tweet.new(content: params["content"])
      @tweet.user = Helpers.current_user(session)
      @tweet.save
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session) && Tweet.find(params[:id]).user == Helpers.current_user(session)
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    binding.pry
  end


end
