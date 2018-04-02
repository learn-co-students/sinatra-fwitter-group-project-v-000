class TweetsController < ApplicationController

  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

end
