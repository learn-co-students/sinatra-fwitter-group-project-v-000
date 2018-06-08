class TweetController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all

    erb :'/tweets/index'
  end

  get '/errors/login' do
    erb :'/errors/login'
  end

  get '/errors/signup' do
    erb :'/errors/signup'
  end
end
