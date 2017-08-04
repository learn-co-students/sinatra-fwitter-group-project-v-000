require 'sinatra/base'
class TweetController < ApplicationController

    enable :sessions
    enable :method_override
 
    get '/tweets' do
        if logged_in?(session)
            @user = current_user(session)
            @tweets = Tweet.all 
            @users = User.all
        else
            redirect to "/login"
        end
        erb :'tweets/tweets'
    end

    get '/tweets/new' do
        if logged_in?(session)
            erb :'tweets/create_tweet'
        else
            redirect to "/login"
        end
    end

    post '/tweets' do
        @tweet = Tweet.new(params)

        if @tweet.content == ""
            redirect to "/tweets/new"
        elsif @tweet.save
            @user = current_user(session)
            @user.tweets << @tweet
            redirect to "/tweets"
         else
            redirect to "/signup"
        end
    end 

    get '/tweets/:id' do
        if logged_in?(session)
            @tweet = current_tweet(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?(session)
            @tweet = current_tweet(params[:id])
            erb :'tweets/edit_tweet'
        else
            redirect to "/login"
        end
    end

    patch '/tweets/:id' do
         @tweet = current_tweet(params[:id])

        if @tweet.content == ""
            redirect to "/tweets/#{@tweet.id}/edit"
        else
            @tweet.content = params["content"]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id' do
        if logged_in?(session)
            @user = current_user(session)
            @tweet = current_tweet(params[:id])
            if @tweet.user_id == @user.id
                @tweet.delete
                redirect to '/tweets'
            else
                redirect to "/login"
            end
        end
    end
end
