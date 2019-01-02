class TweetsController < ApplicationController

    get '/tweets/new' do
        if logged_in?
            @user = User.find(session[:user_id])
            erb :'/tweets/new'
        else
            redirect to ("/login")
        end
    end

    get '/tweets' do
        if logged_in?
            @user = User.find(session[:user_id])
            @all_users = User.all
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect to ("/login")
        end
    end

    post '/tweets' do
        if params[:tweet][:content] == ""
            redirect to ("/tweets/new")
        else
            Tweet.create(params[:tweet])
            redirect to ("/tweets")
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect to ("/login")
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            @user = User.find(session[:user_id])
            erb :'/tweets/edit'
        else
            redirect to ("/login")
        end
    end

    delete '/tweets/:id/delete' do
      @tweet = Tweet.find_by_id(params[:id])
      if logged_in? && current_user.tweets.include?(@tweet)
          @tweet.delete
          redirect to '/tweets'
      else
        redirect to ("/login")
    end

    end

    patch '/tweets/:id' do
        if params[:tweet][:content] == ""
            redirect to ("/tweets/#{params[:id]}/edit")
        else
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.content != params[:tweet][:content]
                @tweet.content = params[:tweet][:content]
                @tweet.save
            end
            redirect to ("/tweets")
        end
    end
end
