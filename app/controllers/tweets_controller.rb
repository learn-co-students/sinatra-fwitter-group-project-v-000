class TweetsController < ApplicationController

  get '/tweets' do
    if session[:id]
      erb :"/tweets/tweets"
    else
      erb :index
    end
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
