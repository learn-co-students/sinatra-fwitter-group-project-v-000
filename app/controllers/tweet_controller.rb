class TweetController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = user
            erb :'/tweets/index'

        else
            redirect to '/login'
        end
    end
end