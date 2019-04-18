class TweetsController < ApplicationController

  get '/tweets' do
    erb :'tweets/tweets'
  end


  get '/tweets/new' do
  end



  post '/tweets' do
    redirect
  end


  get '/tweets/:id' do
  end


  get '/tweets/:id/edit' do
  end



  patch 'tweets/:id' do
  end



  put '/tweets/:id' do
  end


  delete '/tweets/:id' do
  end




end
