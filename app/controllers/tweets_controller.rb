class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @user = current_user
            @tweets = current_user.tweets
            erb :'tweets/index'
        else
            redirect to '/'
        end
    end

    get '/tweets/new' do
        erb :'tweets/new'
    end

    post '/tweets' do 
        tweet = Tweet.create(content: params[:content])
        tweet.user = current_user
        tweet.save
        redirect to '/tweets'
    end

    get '/tweets/:id' do
        erb :'tweets/show'
    end

    patch '/tweets/:id' do 

    end

    delete '/tweets/:id' do

    end

end
