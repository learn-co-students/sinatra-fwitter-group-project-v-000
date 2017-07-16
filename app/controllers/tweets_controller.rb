class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      erb :'tweets/tweets_index'
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

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    binding.pry
    redirect 'tweets/show_tweet'
  end

end
