class TweetController < ApplicationController

  get '/tweets' do

    @user = User.find_by(id: session["user_id"])

    if logged_in
      erb :'tweets/tweets'
    else
      redirect to "users/login"
    end
  end


end
