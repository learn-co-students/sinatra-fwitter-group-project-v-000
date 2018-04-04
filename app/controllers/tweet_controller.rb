class TweetController < ApplicationController
  
  get '/tweets' do
    if User.is_logged_in?(session)
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end 
end