class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @current_user = current_user
    else
      flash[:message] = "Please log in to view tweets!"
      redirect to "/login"
    end
    @tweets = Tweet.all
    erb :"/tweets/tweets"
  end
end
