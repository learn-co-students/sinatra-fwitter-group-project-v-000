class TweetsController < ApplicationController

  get '/tweets/new' do
      erb :create_tweet
    end

end
