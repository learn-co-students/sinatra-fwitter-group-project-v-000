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
            @tweet = current_user.tweets.create(params)
            redirect to "/tweets/#{@tweet.id}"
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
        binding.pry
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user != current_user
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to '/login'
        end
        redirect to '/tweets/edit_tweet'
    end


    patch 'tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if params[:content].empty?
                redirect to "/tweets/#{@tweet.id}/edit"
                @tweet.update(content: params[:content])
            else
            redirect to "/tweets/#{@tweet.id}"
            end
        end
    end

#delete
    post 'tweets/:id/delete' do

    end


end
