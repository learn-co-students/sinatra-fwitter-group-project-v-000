class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        if logged_in?
        erb :'tweets/tweets'
        else
        redirect "/login"
        end
    end
    
    get '/tweets/new' do
        if logged_in?
        erb :'/tweets/new'
        else
        redirect "/login"
        end
    end
    
    post '/tweets' do
        if !params[:content].empty?
        @tweet = Tweet.create(content: params[:content])
        else
        redirect "/tweets/new"
        end
    
        if logged_in?
        @tweet.user_id = current_user.id
        @tweet.save
        end
        redirect "/tweets"
    end
    
    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if logged_in?
        erb :'/tweets/show_tweet'
        else
        redirect "/login"
        end
    end
    
    get '/tweets/:id/edit' do
        if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == current_user.id
            erb :'/tweets/edit_tweet'
        else
            redirect "/tweets"
        end
        else
        redirect "/login"
        end
    end
    
    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        @tweet.update(content: params[:content])
        if !@tweet.content.empty?
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/#{@tweet.id}/edit"
        end
    end
    
    delete '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user_id == current_user.id
          @tweet.destroy
          redirect "/tweets"
        else
          redirect "/login"
        end
    end
end
    


