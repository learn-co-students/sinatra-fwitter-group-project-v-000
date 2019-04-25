class TweetsController < ApplicationController

  get '/tweets' do
    current_user
    erb :'/tweets/tweets'
  end
end
