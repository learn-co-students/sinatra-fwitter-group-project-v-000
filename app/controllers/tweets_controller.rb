class TweetsController < ApplicationController

#index action. index page to display all tweets
    get '/tweets' do
        if logged_in?
            #@user = User.find_by_id(session[:user_id])
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end
#create
#new action. displays create tweet form
    get '/tweets/new' do
        if logged_in?
            @user = current_user
            erb :'/tweets/new'
        else
            redirect to 'login'
        end
    end

#create action. Creates one tweet.
    post '/tweets' do
        if logged_in?
            @tweet = current_user.tweets.create(params)
            redirect to 'tweets/#@tweet.id}'
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
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.username == current_user.username
                erb :'/tweets/edit_tweet'
            else
                erb :'/tweets/tweets'
            end
        else
            redirect to '/login'
        end
    end


    patch 'tweets/:id' do

    end

#delete
    delete 'tweets/:id' do

    end


end
