class TweetsController < ApplicationController

  get '/tweets' do
    if !!session[:id]
      erb :tweets
    else
      redirect '/login'
    end
  end
end
