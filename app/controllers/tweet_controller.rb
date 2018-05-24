class TweetController < ApplicationController

    get '/tweets' do 
        if logged_in? 
            @tweets = Tweet.all
            erb :'/tweets/index'
        else 
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if params[:content].empty?
            redirect '/tweets/new'
        elsif logged_in? && !params[:content].empty?
            @tweet = current_user.tweets.create(content: params[:content])
            @tweet.save ? (redirect "/tweets/#{@tweet.id}") : (redirect '/tweets/new')
        else 
            redirect '/login'
        end
        current_user.save
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else 
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/edit'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if params[:content].empty?
            redirect "/tweets/#{@tweet.id}/edit"
        elsif logged_in? && !params[:content].empty?
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
        else 
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user == current_user then @tweet.delete else redirect '/login' end
        else 
            redirect '/login'
        end
        redirect '/tweets'
    end


end