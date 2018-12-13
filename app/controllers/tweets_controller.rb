class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets' do
    erb :'/tweets/index'
  end
end
