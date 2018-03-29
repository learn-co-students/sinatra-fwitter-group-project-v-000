class TweetsController < ApplicationController

# Show tweets index
  get '/tweets' do    
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

end
