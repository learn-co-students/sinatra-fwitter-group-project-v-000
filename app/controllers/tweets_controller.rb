class TweetsController < ApplicationController

  get '/tweets' do
    if !session[:user_id]
      redirect to '/login'
    else
      erb :'/tweets/tweets'
    end
  end

end
