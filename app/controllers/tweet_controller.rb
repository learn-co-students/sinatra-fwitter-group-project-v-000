class TweetController < ApplicationController

    get '/tweets' do
        if !!session[:id]
            @user = User.find(session[:id])
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if !!session[:id]
            @user = User.find(session[:id])
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        @user = User.find(params[:user_id])
        @tweet = Tweet.new(params)
        if !@tweet.save
            redirect '/tweets/new'
        else
            @tweet.save
            redirect '/tweets'
        end
    end

    get '/tweets/:id' do
        if !!session[:id]
            @user = User.find(session[:id])
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if !!session[:id]
            @user = User.find(session[:id])
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        else
            redirect '/login'
        end
    end

    post '/tweets/:id' do
        @tweet = Tweet.find(params[:tweet_id])
        if params[:content].empty?
            redirect "/tweets/#{@tweet.id}/edit"
        else
            @tweet.content = params[:content]
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        end
    end

    post '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        @user = User.find(session[:id])
        if @user.id == @tweet.user_id
            @tweet.delete
        else
            redirect "/tweets/#{@tweet.id}"
        end
    end

end
