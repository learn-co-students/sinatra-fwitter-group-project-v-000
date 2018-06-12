class TweetController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all

            "BANANAS FOSTER ALL TWEETS PAGE. Welcome, "
            #erb :'/tweets/index'

        else
            redirect to '/login'
        end
    end
end