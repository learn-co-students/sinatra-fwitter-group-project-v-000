class TweetController < ApplicationController


  get '/tweets' do
    if Helpers.logged_in?(session)
      @current_user = Helpers.current_user(session)
      @users = User.all
      erb :"/tweets"
    else
      redirect to '/login'
    end
  end

end
