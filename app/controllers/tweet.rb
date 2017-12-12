class TweetController < ApplicationController


  get '/tweet' do
    erb :"tweets/tweets"
  end
end
