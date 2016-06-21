class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by(session[:email])
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

end