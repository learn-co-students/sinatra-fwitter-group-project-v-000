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

    get '/tweets/:id' do
        if !logged_in?
            redirect to '/login'
        end

        @tweet = Tweet.find(params[:id])

        if !@tweet
            redirect to '/tweets'
        end

        if !user.tweets.include?(@tweet)
            redirect to '/tweets'
        end

        erb :'/tweets/show'
    end

    post '/tweets/:id' do
        if !logged_in?
            redirect to '/login'
        end

        if params[:content].empty?
            session[:edit_tweet_error] = true
            session[:edit_tweet_error_message] = "Tweets must not be blank!"
            redirect to "/tweets/#{params[:id]}/edit"
        end

        tweet = Tweet.find(params[:id])

        if !tweet
            redirect to '/tweets'
        end
        
        if !user.tweets.include?(tweet)
            redirect to '/tweets'
        end

        tweet.content = params[:content]

        tweet.save

        redirect to "/tweets"
    end

    get '/tweets/:id/edit' do
        if !logged_in?
            redirect to '/login'
        end

        @tweet = Tweet.find(params[:id])

        if !@tweet
            redirect to '/tweets'
        end

        if !user.tweets.include?(@tweet)
            redirect to '/tweets'
        end

        session.delete(:edit_tweet_error) ?
            @edit_tweet_error_message = session.delete(:edit_tweet_error_message) :
            @edit_tweet_error_message = ''

        erb :'/tweets/edit'
    end
end