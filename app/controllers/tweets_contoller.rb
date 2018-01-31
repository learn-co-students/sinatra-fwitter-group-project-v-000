class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do

    erb :'tweets/create_tweet'
  end


end
