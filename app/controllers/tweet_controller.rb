class TweetController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      @user = current_user
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    erb :"tweets/new"
  end

end
