class TweetsController < ApplicationController

#Tweet Index
  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

#Edit Tweet
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && tweet.user_id == session[:user_id]

      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end


end
