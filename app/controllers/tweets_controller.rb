class TweetsController < ApplicationController

  get '/tweets' do
    # raise session[:user_id].inspect
    erb :'tweets/tweets'
  end

end
