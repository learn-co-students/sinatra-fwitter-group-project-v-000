class TweetsController < ApplicationController

    get "/tweets" do
        if session[:user_id]
            @tweets = Tweet.all
            erb :"tweets/index"
        else
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if session[:user_id]
            erb :"tweets/new"
        else
            redirect "/login"
        end
    end

    post "/tweets" do
        @tweet = Tweet.new(params)
        if @tweet.save
            redirect "/tweets"
        else
            redirect "/tweets/new"
        end
    end

    get "/tweets/:id" do
        if session[:user_id]
            @tweet = Tweet.find(params[:id])
            erb :"tweets/show"
        else
            redirect "/login"
        end
    end

    delete "/tweets/:id" do
        if !session[:user_id]
            redirect "/login"
        end
        @tweet = Tweet.find(params[:id])
        if session[:user_id] == @tweet.id
            @tweet.destroy
            redirect "/tweets"
        else
            redirect "/tweets/#{@tweet.id}"
        end
    end

    get "/tweets/:id/edit" do
        if !session[:user_id]
            redirect "/login"
        end
        @tweet = Tweet.find(params[:id])
        
        if session[:user_id] == @tweet.user.id
            erb :"tweets/edit"
        else
            redirect "/tweets/#{@tweet.id}"
        end
    end

    patch "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        if @tweet.update(params[:tweet])
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

end
