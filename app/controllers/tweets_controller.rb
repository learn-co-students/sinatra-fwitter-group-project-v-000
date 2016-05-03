class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

end
