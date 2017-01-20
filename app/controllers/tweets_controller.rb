class TweetsController < ApplicationController
  get '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      #binding.pry
      erb :'/tweets/index'
    end
  end
end
