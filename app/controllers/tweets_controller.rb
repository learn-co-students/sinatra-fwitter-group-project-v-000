class TweetsController < ApplicationController
  get '/tweets' do
    if !session[:id].nil?
      @user = User.find_by(session[:id])
      erb :'tweets/index'
    else
      redirect :'login'
    end
  end

  get '/tweets/new' do
    if !session[:id].nil?
      erb :'tweets/new'
    else
      redirect :'login'
    end
  end

  post '/tweets/new' do
    if params["tweet"]["content"].nil? || params["tweet"]["content"] == ""
      redirect :'tweets/new'
    else
      user = User.find_by(session[:id])
      tweet = Tweet.new(params["tweet"])
      user.tweets << tweet
      redirect to("/tweets/#{tweet.id}")
    end
  end

  get '/tweets/:id' do
    @tweet =  Tweet.find_by(params[:id])
    erb :'tweets/show'
  end

end
