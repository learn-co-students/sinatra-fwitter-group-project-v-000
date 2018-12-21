class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
  end

  get '/tweets/new' do

    erb :'/tweets/new'
  end

  post '/tweets' do

    redirect to ''
  end

  get '/tweets/:id' do

    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do

    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do

    redirect to ''
  end

  delete '/tweets/:id/delete' do

    redirect to ''
  end


end
