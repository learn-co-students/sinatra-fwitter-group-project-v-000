class TweetController < ApplicationController
  get '/tweets' do
    redirect '/login' unless session.key?(:user_id)
    @tweets = Tweet.all
    @username = User.find(session[:user_id]).username
    erb :'tweets/index'
  end
end
