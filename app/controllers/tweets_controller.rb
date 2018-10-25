class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/twitter/index'
    else
      redirect to "/users/login"
    end
  end

end
