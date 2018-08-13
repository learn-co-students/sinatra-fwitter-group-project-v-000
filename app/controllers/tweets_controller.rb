class TweetsController < ApplicationController

  get '/tweets' do
    raise inspect.params
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end


end
