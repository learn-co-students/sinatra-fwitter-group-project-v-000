class TweetController < ApplicationController

      get "/tweets/new" do
        if logged_in?
          erb :'tweets/create_tweet'
        else
          redirect "/login"
        end
      end

      post "/tweets" do
        if params["content"] == ""
          redirect to "/tweets/new"
        else
          tweet = Tweet.new(content: params["content"], user_id: current_user.id)
          current_user.tweets << tweet
          current_user.save
          redirect to "/tweets"
        end
      end

      get "/tweets" do
        if logged_in?
          @user = current_user
          @tweets = Tweet.all
          erb :"tweets/tweets"
        else
          redirect "/login"
        end
      end

      get '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find_by(id: params[:id])
          erb :'tweets/show_tweet'
        else
          redirect "/login"
        end
      end

      get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          erb :'tweets/edit_tweet'
        else
          redirect to "/login"
        end
      end

      patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])

        if params["content"] != ""
          @tweet.content = params["content"]
          @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/#{@tweet.id}/edit"
        end
      end

      delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user_id == current_user.id
          @tweet.delete
          redirect to "/tweets"
        else
          redirect to '/login'
        end
      end
end
