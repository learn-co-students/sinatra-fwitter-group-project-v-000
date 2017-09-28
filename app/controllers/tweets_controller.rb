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
    @tweet = Tweet.find(params[:id])
    if !logged_in?
      redirect "/login"
    elsif logged_in? && current_user == @tweet.user
      erb :"tweets/edit"
    elsif logged_in?
      redirect "/tweets"
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] != ""
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      flash[:message] = "Edited tweets must contain text. Please click delete tweet to permanently remove tweet."
      redirect "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user == tweet.user
      tweet.delete
      redirect "/tweets"
    elsif logged_in?
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user == tweet.user
      tweet.delete
      redirect "/tweets"
    elsif logged_in?
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end
end
