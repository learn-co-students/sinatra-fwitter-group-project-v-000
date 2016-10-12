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
    if params[:content].nil?
      redirect :'tweets/new'
    else
      user = User.find_by(session[:id])
      tweet = Tweet.new(params)
      user.tweets << tweet
      redirect '/user/#{user.slug}'
    end
  end

end
