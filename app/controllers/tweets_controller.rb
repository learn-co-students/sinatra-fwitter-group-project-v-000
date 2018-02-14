class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    end
  end

  post '/tweets' do

  end
end
