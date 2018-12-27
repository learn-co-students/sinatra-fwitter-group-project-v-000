class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

end
