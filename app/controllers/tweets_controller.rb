class TweetsController < ApplicationController

  # get '/tweets' do
  #   # raise session[:user_id].inspect
  #   # if logged_in
  #     erb :'tweets/tweets'
  #   # end
  # end

    get '/tweets' do
      if !logged_in?
        redirect '/login'
      else
        @tweets = Tweet.all
        erb :'tweets/tweets'
      end
    end

    get '/tweets/new' do
      if logged_in?
        erb :'tweets/create_tweet'
      else
        redirect to '/login'
      end
    end

    post '/tweets' do
      @tweet = Tweet.find_by(:content => params[:content])
      @user = User.find_by(:username => params[:username])
    end

end
