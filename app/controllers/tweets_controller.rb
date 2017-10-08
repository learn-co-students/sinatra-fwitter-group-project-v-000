class TweetsController < ApplicationController

    get '/tweets' do
        erb :'/tweets/tweets'
    end

    get '/tweets/:id' do
        erb :'/tweets/show_tweet'
    end
    
end