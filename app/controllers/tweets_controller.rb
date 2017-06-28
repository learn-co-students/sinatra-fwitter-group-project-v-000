class TweetsController < ApplicationController

  get '/tweets' do
    erb :"/tweets/tweets"
  end

  get '/tweets/new' do

  end

  post '/tweets' do

  end

  get '/tweets/:id' do
    erb :"/tweets/show"
  end

  get '/tweets/:id/edit' do

  end

  patch '/tweets/:id' do

  end

  delete '/tweets/:id' do
    
  end
end
