class TweetController < ApplicationController
  
  get '/tweets' do
    if User.is_logged_in?(session)
      @user = User.find_by(id: session[:user_id])
      @tweets = Tweet.all 
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end 
end