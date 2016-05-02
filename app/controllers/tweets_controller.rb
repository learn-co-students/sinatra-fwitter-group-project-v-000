class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :tweets
    else
      redirect '/login'
    end
  end

end
