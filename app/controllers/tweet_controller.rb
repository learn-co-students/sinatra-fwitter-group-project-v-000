class TweetController < ApplicationController
    get '/tweets' do
        @tweets = Tweet.all

        "BANANAS FOSTER ALL TWEETS PAGE. Welcome, "
        #erb :'/tweets/index'
    end
end