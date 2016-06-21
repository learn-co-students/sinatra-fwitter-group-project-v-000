class TweetsController < ApplicationController

  get '/tweets' do
    binding.pry
    if logged_in?
      @user = User.find_by(session[:email])
      @tweets = Tweet.all
      binding.pry
      erb :"/tweets/tweets"
    # else
    #   redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
  end

end
