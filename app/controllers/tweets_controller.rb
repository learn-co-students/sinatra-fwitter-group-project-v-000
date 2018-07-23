class TweetsController < ApplicationController

    get "/tweets" do

        if !logged_in?
            redirect "/login"
        end

        @tweets = Tweet.all

        erb :"tweets/index"
    end

    get "/tweets/new" do
        erb :"tweets/new"
    end

    post "/tweets" do
        if params["tweet"]["content"] == ""
            erb :"tweets/new"
        end

        @tweet = Tweet.create(content: params["tweet"]["content"], user: current_user)
        redirect "/tweets"
        
    end



end
