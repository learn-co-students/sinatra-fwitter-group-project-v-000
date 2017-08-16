class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :"/tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save
    redirect "/tweets"
  end

  post '/tweets/new' do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect "/tweets"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete if @tweet.user_id == session[:user_id]
    redirect "/tweets"
  end
end
