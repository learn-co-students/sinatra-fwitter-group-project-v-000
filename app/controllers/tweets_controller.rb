class TweetsController < ApplicationController

#TWEET INDEX
  get '/tweets' do
#    binding.pry
    if logged_in? #!!session[:user_id] == true
      erb :'/users/show'
    else
      redirect '/login'
    end
  end

  # CREATE TWEET
    get '/tweets/new' do

      erb :'/tweets/create_tweet'
    end

    post '/tweets' do

    end

  # SHOW TWEET
    get '/tweets/:id' do
      #binding.pry
      erb :'/tweets/show_tweet'
    end

  # EDIT TWEET
    get '/tweets/:id/edit' do

      erb :'tweets/edit_tweet'
    end

    patch '/tweets/:id' do

    end

  # DELETE TWEET
    delete '/tweets/:id/delete' do

    end
end
