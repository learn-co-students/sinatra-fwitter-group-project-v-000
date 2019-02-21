class TweetsController < ApplicationController
  get '/tweets' do
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    if !logged_in?
      redirect "/login"
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end

  # get 'tweets/:id/edit' do
  #
  # end
end
