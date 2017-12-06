class TweetController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    end
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do

    @tweet = Tweet.create(params)
    @tweet.user_id = current_user
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end

end
