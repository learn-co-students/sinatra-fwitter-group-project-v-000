class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :"/tweets/tweets"
        else
            redirect to "/users/login"
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :"/tweets/create_tweet"
        else
            redirect to "/login"
        end
        
    end
    
    post '/tweets' do
        @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
        
        if @tweet.save
            redirect to "/tweets"
        else 
            redirect to "/tweets/new"
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :"/tweets/show_tweet"
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :"/tweets/edit_tweet"
        else
            redirect to "/login"
        end
        
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        if @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user_id == current_user.id
                @tweet.destroy
                redirect to "/tweets"
            end
        else
            redirect to "/login"
        end
    end

end