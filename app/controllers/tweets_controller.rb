class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweets.all
    erb :'tweets/tweets'
  end

end
