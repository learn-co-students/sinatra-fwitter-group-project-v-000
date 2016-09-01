class TweetsController < ApplicationController

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  ######## CREATE TWEET #########
  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    erb :'/tweets/tweets'
  end

  ######## SHOW TWEET #########
  get '/tweets/:id' do ##not sure about id
    erb :'/tweets/show_tweet'
  end

  ######## EDIT TWEET #########
  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do
    erb :'/tweets/show_tweet'
  end

  ######## DELETE TWEET #########

  post '/tweets/:id/delete' do
    erb :'/tweets/show_tweet'
  end

end
