class TweetController < ApplicationController
  get '/tweets' do
    @user = User.find(session[:user_id])
    erb :'/tweets/index'
  end
end
