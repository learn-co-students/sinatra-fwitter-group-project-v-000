class TweetsController < ApplicationController

    post '/tweets' do
        if params["tweet"]["content"] != ""
            @tweet = Tweet.create(params["tweet"])
            @tweet.user_id = session[:user_id]
            @tweet.save
        else 
            flash[:message] = "You cannot post a blank tweet." 
            redirect '/tweets/new' 
        end
    end

    get '/tweets/new' do
        @status = Helpers.is_logged_in?(session)

        if @status == true
            @user = Helpers.current_user(session)
            erb :'/tweets/new'
        else 
            flash[:message] = "You must be logged in to see this page." 
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find(params[:id])

        erb :'/tweets/edit_tweet'
    end

    get '/tweets/:id' do
        @status = Helpers.is_logged_in?(session)

        if @status == true
            @tweet = Tweet.find(session[:user_id])
            erb :'/tweets/show_tweet'
        else 
            redirect '/login'
        end
    end
    
    get '/tweets' do
        # @current_user = Helpers.current_user(session)
        @status = Helpers.is_logged_in?(session)
        @tweets = Tweet.all
        
        if @status == true
            erb :'/tweets/tweets'
        else 
            flash[:message] = "You must be logged in to see this page." 
            redirect '/login'
        end
    end


end
