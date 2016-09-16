class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?(session)
      erb :"/tweets/index"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    erb :show
  end
end
