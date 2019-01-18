class TweetsController < ApplicationController
    #This controlled will control all tweet actions/routes.


    get '/tweets' do
        erb :'/tweets/index'
    end

    post '/tweets/index' do
        @tweets = Tweet.all
        redirect to '/tweets'
    end


end
