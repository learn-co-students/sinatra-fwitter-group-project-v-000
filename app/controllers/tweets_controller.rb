class TweetsController < ApplicationController

  get '/tweets' do
    binding.pry
    if logged_in?
      @user = current_user
      binding.pry
      erb :'tweets/tweets'
    else
      redirect to("/login")
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect to("/login")
    else
      @user = current_user
      erb :'tweets/create_tweet'
    end

  end


end
