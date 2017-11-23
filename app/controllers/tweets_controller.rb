class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      "Welcome, #{session[:username]}"
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    "hello world"
  end

  get '/tweets/new' do
    if !logged_in?
      redirect "/login"
    else
    erb :'tweets/create_tweet'
    end
  end

  get '/tweets/edit' do
   if !logged_in?
      redirect "/login"
    else
    erb :'tweets/edit_tweet'
    end
  end

  get '/tweets/:slug' do
    if !logged_in?
      redirect "/login"
    else
    erb :'tweets/show_tweet'
    end
  end


end

