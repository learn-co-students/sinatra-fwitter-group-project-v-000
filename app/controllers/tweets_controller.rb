class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      flash[:message] = "Please log in to view the tweets."
      redirect '/login'
    end
  end

end
