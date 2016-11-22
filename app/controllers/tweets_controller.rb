require './config/environment'
class TweetsController < ApplicationController
  get '/tweets' do
    if is_logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do

    erb :'/tweets/create_tweet'
  end
end
