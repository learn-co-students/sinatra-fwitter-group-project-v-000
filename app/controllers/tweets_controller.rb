class TweetsController < ApplicationController


    get '/tweets' do
        if is_logged_in?
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        #binding.pry
        if is_logged_in?
            erb :'/tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets/' do

    end

    get '/tweets/:id' do
        if is_logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if is_logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
                erb :'/tweets/edit_tweet'
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do

    end

    delete '/tweets/:id/delete' do
        if is_logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && tweet.user == current_user
                @tweet.delete
            end
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end
end
