class TweetsController < ApplicationController

# Show tweets index
  get '/tweets' do
    @user = current_user
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

end
