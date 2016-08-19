class TweetController < ApplicationController

  get '/tweets/new' do
    erb :"/tweets/new"
  end

  post '/tweets' do
    
    redirect to "/tweets/#{tweet.id}"
  end

end
