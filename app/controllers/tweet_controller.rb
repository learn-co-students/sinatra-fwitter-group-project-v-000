require './config/environment'

class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    redirect "/tweets"
  end
end
