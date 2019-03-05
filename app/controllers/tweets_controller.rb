class TweetsController < ApplicationController

#index action. index page to display all tweets
    get '/tweets' do
        if logged_in?
            @user = current_user
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end
#create
#new action. displays create tweet form
    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect to '/login'
        end
    end
#create action. Creates one tweet.
    post '/tweets' do
        if params[:content] != ""
            tweet = current_user.tweets.create(params)
        else
            redirect to '/tweets/new'
        end
    end

#Read
    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

#update

    get 'tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            redirect to '/tweets/edit_tweet'
        else
            redirect to '/login'
        end
    end


    patch 'tweets/:id' do
        tweet = Tweet.find(params[:id])
        if params[:content].empty?
            tweet.update(content: params[:content])
        else
            redirect to "/tweets/#{params[:id]/edit}"
        end
    end

#delete
    post 'tweets/:id/delete' do

    end


end
