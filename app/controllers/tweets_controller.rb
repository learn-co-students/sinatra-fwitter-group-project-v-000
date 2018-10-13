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
        @status = Helpers.is_logged_in?(session)

        if @status
            @tweets = Tweet.all.select {|tweet| tweet.user_id == session[:user_id]}
            erb :'/tweets/tweets'
        else 
            flash[:message] = "You must be logged in to see this page." 
            redirect '/login'
        end 
    end

    get '/tweets/new' do
        @status = Helpers.is_logged_in?(session)

        if @status
            @user = Helpers.current_user(session)
            erb :'/tweets/new'
        else 
            flash[:message] = "You must be logged in to see this page." 
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        @status = Helpers.is_logged_in?(session)

        if @status && session[:user_id] == Tweet.find(params[:id].to_i).user_id
            @tweet = Tweet.find(params[:id])
            @tweet.destroy
            redirect '/tweets'
        elsif @status && session[:user_id] != Tweet.find(params[:id].to_i).user_id
            flash[:message] = "You cannot delete another's tweet." 
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @status = Helpers.is_logged_in?(session)

        if @status && session[:user_id] == Tweet.find(params[:id].to_i).user_id
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
        @status = Helpers.is_logged_in?(session)

        if @status
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else 
            redirect '/login'
        end
    end
    
    get '/tweets' do
        # binding.pry
        @status = Helpers.is_logged_in?(session)
        @tweets = Tweet.all
        
        if @status
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
