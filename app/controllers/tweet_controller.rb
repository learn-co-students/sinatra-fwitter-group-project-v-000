class TweetController < ApplicationController

  get '/tweets' do
    erb :"/tweets/index"
  end

  get '/tweets/:id' do
    erb :show
  end
end
