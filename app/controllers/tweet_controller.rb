class TweetController < ApplicationController
    get '/tweets' do
        if !logged_in?
            redirect to '/login'
        end

        @tweets = Tweet.all

        erb :'/tweets/index'
    end

    post '/tweets' do
        if !logged_in?
            redirect to '/login'
        end

        if params[:content].empty?
            session[:new_tweet_error] = true
            session[:new_tweet_error_message] = 'Tweets must not be blank!'
            redirect to '/tweets/new'
        end

        tweet = Tweet.create(content: params[:content])
        tweet.user = user
        tweet.save


        redirect to '/tweets'
    end

    get '/tweets/new' do
        if !logged_in?
            redirect to '/login'
        end

        session.delete(:new_tweet_error) ?
            @new_tweet_error_message = session.delete(:new_tweet_error_message) :
            @new_tweet_error_message = ''

        erb :'/tweets/new'
    end
end