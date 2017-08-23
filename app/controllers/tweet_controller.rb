class TweetsController < ApplicationController

    get '/tweets' do
      if logged_in?
        @user = @current_user
        erb :"tweets/tweets"
      else
        redirect "/login"
      end
    end

    get '/tweets/new' do
      if logged_in?
        @user = @current_user
        erb :"tweets/create_tweet"
      else
        redirect "/login"
      end
    end

    post '/tweets' do
      if params[:content]==""
        redirect "/tweets/new"
      else
        @user = User.find(session[:id])
        @tweet = Tweet.create(content: params[:content], user_id: @user.id)
        @user.tweets << @tweet
        redirect "/users/#{@user.slug}"
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :"tweets/show_tweet"
      else
        redirect "/login"
      end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user == @current_user
          if params[:content] ==""
            redirect "/tweets/#{@tweet.id}/edit"
          else
            @tweet.update(content: params[:content])
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
          end
        else
          redirect "/tweets/#{@tweet.id}"
        end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user == @current_user
          erb :"tweets/edit_tweet"
        else
          redirect "/tweets"
        end
      else
        redirect "/login"
      end
    end

    delete '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.delete
        redirect "/users/#{current_user.slug}"
      else
        redirect "/tweets"
      end
    end
end
