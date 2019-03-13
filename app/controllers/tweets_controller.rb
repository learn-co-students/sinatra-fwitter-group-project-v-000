class TweetsController < ApplicationController

    get "/tweets" do
        if logged_in?
            @tweets = Tweet.all
            erb :"tweet/index"
        else
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if logged_in?
            erb :"tweet/new"
        else
            redirect "/login"
        end
    end

    post "/tweets" do
        @tweet = Tweet.new(params)
        @tweet.user = current_user

        @tweet.save ? redirect("/tweets/#{@tweet.id}") : redirect("/tweets/new")
    end

    get "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"tweet/show"
        else
            redirect "/login"
        end
    end

    get "/tweets/:id/edit" do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"tweet/edit"
        else
            redirect("/login")
        end
    end

    patch "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        if @tweet.user == current_user
            @tweet.update(content: params[:content])
            @tweet.save ? redirect("/tweets/#{@tweet.id}") : redirect("/tweets/#{@tweet.id}/edit")
        else
            redirect("/login")
        end
    end

    delete "/tweets/:id" do
        tweet = Tweet.find(params[:id])
        if tweet.user == current_user
            tweet.destroy
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

end
