class TweetsController < ApplicationController

  get '/tweets/new' do
    @tweets = Tweet.all
    erb :'tweets/new'
  end

end
