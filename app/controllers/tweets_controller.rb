class TweetsController < ApplicationController

  get '/tweets' do
    if session[:id]
      @user = current_user
      erb :"/tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do

  end

  post '/tweets' do

  end

  get '/tweets/:id' do
    erb :"/tweets/show_tweet"
  end

  get '/tweets/:id/edit' do

  end

  patch '/tweets/:id' do

  end

  delete '/tweets/:id' do

  end
end
