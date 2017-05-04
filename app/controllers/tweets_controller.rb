class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

end
