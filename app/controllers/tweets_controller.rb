class TweetsController < ApplicationController
    post '/tweets' do
        if params["tweet"]["content"] != ""
            @tweet = Tweet.create(params["tweet"])
            @tweet.user_id = session[:user_id]
            @tweet.save
            flash[:message] = "You've tweeted!" 
            redirect '/tweets'
        else 
            flash[:message] = "You cannot post a blank tweet." 
            redirect '/tweets/new' 
        end
    end

    get '/tweets/mytweets' do
        if logged_in
            @tweets = Tweet.all.select {|tweet| tweet.user_id == session[:user_id]}
            erb :'/tweets/tweets'
        else 
            flash[:message] = "You must be logged in to see this page." 
            redirect '/login'
        end 
    end

    get '/tweets/new' do
        if logged_in
            @user = current_user
            erb :'/tweets/new'
        else 
            flash[:message] = "You must be logged in to see this page." 
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in && session[:user_id] == Tweet.find(params[:id].to_i).user_id
            @tweet = Tweet.find(params[:id])
            @tweet.destroy
            redirect '/tweets'
        elsif logged_in && session[:user_id] != Tweet.find(params[:id].to_i).user_id
            flash[:message] = "You cannot delete another's tweet." 
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in && session[:user_id] == Tweet.find(params[:id].to_i).user_id
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit_tweet'
        elsif @status && session[:user_id] != Tweet.find(params[:id].to_i).user_id
            flash[:message] = "You cannot edit another's tweet." 
            redirect '/tweets'
        else 
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else 
            redirect '/login'
        end
    end
    
    get '/tweets' do
        @tweets = Tweet.all
        
        if logged_in
            erb :'/tweets/tweets'
        else 
            flash[:message] = "You must be logged in to see this page." 
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])

        if params["tweet"]["content"] != ""
            @tweet.update(params["tweet"])
            redirect "/tweets/#{@tweet.id}"
        else
            flash[:message] = "A tweet cannot be blank!" 
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end
end
