class TweetsController < ApplicationController

#index action. index page to display all tweets
    get '/tweets' do
        if logged_in?
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end
#create
#new action. displays create tweet form
    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

#create action. Creates one tweet.
    post '/tweets' do
        if params[:content].empty?
            redirect to '/tweets/new'
        else
            redirect to '/login'
        end
    end

#Read
    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

#update

    get 'tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])
        @user = User.find_by(is: session[:user_id])
        if !logged_in?
            redirect to '/login'
        elsif logged_in? && @user.tweets.include?(@tweet)
            erb :'tweets/edit_tweet'
        else
            redirect to '/tweets'
        end
    end


    patch 'tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if params[:content].empty?
            redirect to "/tweets/#{@tweet.id}/edit"
        else
            @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
        end
    end

#delete
    delete 'tweets/:id' do

    end


end
