class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = current_user.tweets
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
         @tweets = Tweet.all
        erb :'tweets/create_tweet'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if logged_in?
            if Tweet.new(params[:content]).empty?
                redirect '/tweets/new'
            else
                @tweet = current_user.tweets.build(params[:content])
                if @tweet.save
                redirect "/tweets/#{@tweet.slug}"
        else
            redirect '/tweets/new'
            end
        end
            else
                redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :"tweets/show"
        else
            redirect to '/login'
        end
    end

    get '/tweets/:slug/edit' do
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
            erb :'tweets/edit_tweet'
        else
            redirect '/tweets'
        end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        if logged_in?
        @tweet = Tweet.find_by_id(params[id])
        if @tweet && @tweet.user == current_user
            @tweet.update(params[:content])
            if !params[:content].empty?
            redirect "/tweets/#{@tweet.id}/edit"
            end
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/tweets'
        end
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
            @tweet.delete
            redirect to '/tweets'
        end
        redirect to '/tweets'
        else
        redirect to '/login'
        end
    end
end
