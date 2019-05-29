class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      # @tweet = Tweet.all
      redirect "/login"
    else
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content])
    @tweet.save
  end

  get '/tweets/:id' do

  end

  get '/tweets/:id/edit' do

  end

  post '/tweets/:id' do

  end

  post '/tweets/:id/delete' do

  end

  # get '/tweets' do
  # end


end
