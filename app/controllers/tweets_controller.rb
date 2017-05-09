class TweetsController < ApplicationController

  get '/tweets' do
    if session[:id]
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

end
