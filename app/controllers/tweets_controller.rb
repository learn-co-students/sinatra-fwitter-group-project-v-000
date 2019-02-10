require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do

    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tweets = @user.tweets
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

end
