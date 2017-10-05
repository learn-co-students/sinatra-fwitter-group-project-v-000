class TweetsController < ApplicationController

  # get '/tweets' do
  #   # raise session[:user_id].inspect
  #   # if logged_in
  #     erb :'tweets/tweets'
  #   # end
  # end

    get '/tweets' do
      if !logged_in?
        redirect '/login'
      else
        @tweets = Tweet.all
        erb :'tweets/tweets'
      end
    end

end
