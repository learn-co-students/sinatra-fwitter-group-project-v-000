class TweetController < ApplicationController

  get '/tweets' do
    if session[:user_id].nil?
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      "Welcome, #{@user.username}"
    end

    # @tweets = Tweet.all
    # erb :'/tweets/index_tweet'
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    @tweet =
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id' do

  end

  get '/tweets/:id/edit' do

  end

  post '/tweets/:id' do


  end

  post 'tweets/:id/delete' do


  end

end
