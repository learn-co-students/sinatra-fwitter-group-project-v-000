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

     post '/tweets/new' do
        @user = current_user
        @tweet = Tweet.create(content: params[:content], user: @user)
        binding.pry
        if @tweet.save
            
            redirect to "/tweets"
        else
            redirect to 'tweets/create_tweet'
        end
    end

    # post '/tweets' do
    #     # user = current_user
    #     if !params[:content].empty?
    #         @tweet = Tweet.create(:content=>params[:content], user:current_user)
    #         current_user.tweets << @tweet
    #         current_user.save
    #         redirect '/tweets'
    #     else
    #         redirect '/tweets/new'
    #     end
    # end

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
