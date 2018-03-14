class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

    get '/tweets/new' do
      if logged_in?
        @user = User.find(session[:user_id])
        erb :'/tweets/new'
      else
        redirect to '/login'
      end
    end

end
