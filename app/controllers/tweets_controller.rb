class TweetsController < ApplicationController
    
    get '/tweets' do
        if is_logged_in?
        @user = current_user
        @tweet = Tweet.all
        erb :'tweets/tweets'
        else
        redirect '/login'
        end
    end

    get '/tweets/new' do
        if is_logged_in?
            @user = current_user
            erb :'tweets/create_tweet'
        else
            redirect '/login'
        end
    end

     post '/tweets' do
        @user = current_user
        # @tweet = Tweet.create(content: params[:content], user: @user)
        if !params[:content].empty?
            @tweet = Tweet.create(:content=>params[:content], user: @user)
            @user.tweets << @tweet
            @user.save

            redirect to "/tweets"
        else
            redirect to 'tweets/new'
        end
    end

    get '/tweets/:id' do
        if is_logged_in?
        @user = current_user
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show_tweet'
        else
        redirect to '/login'
        end
    end

end
