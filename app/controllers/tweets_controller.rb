class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] == ""
       redirect "/tweets/new"
    elsif logged_in?
       tweet = Tweet.create(params)
       tweet.user = current_user
       current_user.tweets << tweet
       current_user.save
       tweet.save
       redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        erb :"tweets/edit"
      end
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] != "" && current_user == tweet.user
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    elsif params[:content] == "" && current_user == tweet.user
      flash[:message] = "Edited tweets must contain text."
      redirect "/tweets/#{tweet.id}/edit"
    else
      redirect "/tweets"
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      if current_user.id == tweet.user_id
        tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end
end
