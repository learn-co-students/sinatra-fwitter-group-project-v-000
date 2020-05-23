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

    # get '/tweets/:id/edit' do
    #     @tweet = Tweet.find_by(id: params[:id])
    #     if logged_in? && @tweet.user == current_user
    #         erb :"tweets/edit"
    #     else
    #         redirect to '/login'
    #     end
    # end

     get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if is_logged_in? && @tweet.user == current_user
            erb :'/tweets/edit'
        else
            redirect 'login'
        end
    end

    patch '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        @user = current_user
        if !params[:content].empty? 
            @tweet.update(:content => params[:content])
            @tweet.save
            redirect "tweets/#{@tweet[:id]}"
        else 
            redirect "tweets/#{@tweet[:id]}/edit"
        end
    end

    post '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        if current_user == @tweet.user
            @tweet.delete
            redirect to '/tweets'
        else
            redirect to "/tweets/#{params[:id]}"
        end
    end
end
