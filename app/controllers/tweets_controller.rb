class TweetsController < ApplicationController

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    end
    erb :'/tweets/create_tweet'
  end

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      erb :'/tweets/tweets'
    end
  end 

end
