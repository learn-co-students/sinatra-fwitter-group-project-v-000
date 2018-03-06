class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

end
