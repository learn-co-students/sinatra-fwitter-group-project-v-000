class TweetsController < ApplicationController

    get '/tweets' do
        if !Helper.logged_in?(session)
            redirect to '/login'
        else
            @tweets = Tweet.all 
            @user = Helper.current_user(session)
            erb :'tweets/tweets'
        end
    end

    get '/tweets/new' do 
        if !Helper.logged_in?(session)
            redirect to '/login'
        else
        erb :'tweets/new'
        end
    end

    post '/tweets' do 
        if params["content"].empty?
            flash[:empty_tweet_error] = "Unable to create blank tweets."
            redirect '/tweets/new'
        end
        @tweet = Tweet.create(:content => params["content"])
        @user = Helper.current_user(session)
        @tweet.user_id = @user.id
        @tweet.save
    end

    get '/tweets/:id' do
        if !Helper.logged_in?(session)
            redirect to '/login'
        else
            @tweet = Tweet.find(params[:id])
            erb :'tweets/show_tweet'
        end
    end
    
    get '/tweets/:id/edit' do
        if !Helper.logged_in?(session)
            redirect '/login'
        end

        @tweet = Tweet.find(params[:id])
        @user = Helper.current_user(session)
        erb :'tweets/edit_tweet'
    end
    
    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        @user = Helper.current_user(session)

        if params["content"].empty?
            redirect to "/tweets/#{@tweet.id}/edit"
        elsif
            @user.id != @tweet.user_id
            redirect to '/tweets'
        else
            @tweet.content = params["content"]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        end

    end

    delete '/tweets/:id/delete' do
        if Helper.logged_in?(session) 
            @tweet = Tweet.find(params[:id])
            @user = Helper.current_user(session)
            if @user.id == @tweet.user_id
                @tweet.delete
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end

    end

end
