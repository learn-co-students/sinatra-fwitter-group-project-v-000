class TweetsController < ApplicationController
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/all'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to "/tweets/new"
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
    end
  end

  get '/tweet/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end
  
end
