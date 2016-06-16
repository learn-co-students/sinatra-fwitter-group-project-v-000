require './config/environment'

class TweetsController < ApplicationController

get '/tweets' do
    "hello world" 
    erb :'tweets/tweets'
  end

  post '/tweets' do
    "hello world"
  end

  get '/tweets/create_tweet' do
    if logged_in?.empty?
      redirect "/users/login"
    else
      erb :'tweets/create_tweet'
    end
  end

 get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

end