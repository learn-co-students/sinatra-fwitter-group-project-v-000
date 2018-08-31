class TweetsController < ApplicationController

    get '/tweets' do
        redirect to '/login' unless logged_in?
        @user = current_user
        @tweets = Tweet.all
        erb :'tweets/tweet'
    end

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        else
            erb :'tweets/create_tweet'
        end
    end

    post '/tweets' do
        if !logged_in?
            redirect '/login'
        else
            if params[:content].empty?
                redirect '/tweets/new'
            else
                user = User.find(session[:user_id])
                user.tweets.create(content: params[:content])
                redirect '/tweets'
            end
        end
    end

    get '/tweets/:id' do
        redirect 'login' unless logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show_tweet'
    end

    get '/tweets/:id/edit' do
        redirect 'login' unless logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'tweets/edit_tweet'
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if params[:content].empty?
            redirect '/tweets/#{tweet.id}/edit'
        else
            @tweet.update(content: params[:content])
            @tweet.save
            redirect '/tweets/#{tweet.id}'
        end
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
    end
end
