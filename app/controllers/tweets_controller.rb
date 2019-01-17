class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets' do
    @tweet = Tweet.create(params[:tweet])
    
  end

end
