class TweetsController < ApplicationController

  get '/' do
    redirect :index
  end

  get '/index' do
    @tweets = Tweet.all
    erb :index
  end
end
