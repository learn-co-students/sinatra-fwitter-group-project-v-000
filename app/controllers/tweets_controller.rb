class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      flash[:notice] = "Please log in first to view tweets."
      redirect to '/login'
    end
  end
end
