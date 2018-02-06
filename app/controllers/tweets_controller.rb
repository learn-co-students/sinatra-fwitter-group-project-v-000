class TweetsController < ApplicationController

#TWEET INDEX
  get '/tweets' do
    #binding.pry
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end
# CREATE TWEET
  get '/tweets/new' do
    #binding.pry
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    #binding.pry
  end
# SHOW TWEET
  get '/tweets/:id' do
    # binding.pry
    erb :'/tweets/show_tweet'
  end
# EDIT TWEET
  get '/tweets/:id/edit' do
    #binding.pry
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    #binding.pry
  end
# DELETE TWEET
  delete '/tweets/:id/delete' do
    #binding.pry
  end
end
