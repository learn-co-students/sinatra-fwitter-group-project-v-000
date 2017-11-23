class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

end
