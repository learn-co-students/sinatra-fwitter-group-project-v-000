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



end
