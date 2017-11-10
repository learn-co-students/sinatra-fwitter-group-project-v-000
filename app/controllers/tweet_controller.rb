class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

end
