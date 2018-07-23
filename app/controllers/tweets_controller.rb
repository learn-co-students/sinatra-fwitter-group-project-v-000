class TweetsController < ApplicationController

    get "/tweets" do

        if !logged_in?
            redirect "/login"
        end

        @tweets = Tweet.all

        erb :"tweets/index"
    end

    get "/tweets/new" do
        if !logged_in?
            redirect "/login"
        end

        erb :"tweets/new"
    end

    post "/tweets" do
        if !logged_in?
            redirect "/login"
        end

        if params["tweet"]["content"] == ""
            redirect "/tweets/new"
        else
            @tweet = Tweet.create(content: params["tweet"]["content"], user: current_user)
            redirect "/tweets"
        end
            
    end

    get "/tweets/:id" do
        if !logged_in?
            redirect "/login"
        end

        @tweet = Tweet.find(params[:id])

        if @tweet.user != current_user
            redirect "/login"
        end

        erb :"/tweets/show"
    end

    get "/tweets/:id/edit" do
        if !logged_in?
            redirect "/login"
        end

        @tweet = Tweet.find(params[:id])
        
        if @tweet.user != current_user
            redirect "/login"
        end

        erb :"tweets/edit"

    end

    patch "/tweets/:id" do

        @tweet = Tweet.find(params[:id])

        if params["content"] == ""
           redirect "tweets/#{@tweet.id}/edit"
        else
            @tweet.update(content: params["content"])
            redirect "tweets/#{params[:id]}"
        end

    end

    post "/tweets/:id/delete" do
        if !logged_in?
            redirect "/login"
        end

        @tweet = Tweet.find(params[:id])
        
        if @tweet.user != current_user
            redirect "/login"
        end

        @tweet.destroy

    end

end
