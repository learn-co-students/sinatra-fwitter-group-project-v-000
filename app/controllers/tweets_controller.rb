class TweetsController < ApplicationController

  get '/tweets' do
    if !Helper.is_logged_in?(session)
      redirect :'/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    end
  end
end
