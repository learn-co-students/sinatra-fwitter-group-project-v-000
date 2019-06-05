class TweetsController < ApplicationController

  get '/test' do
    "how about this one?"
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.new(params)

    erb :'tweets/show'
  end

end
