class TweetsController < ApplicationController

  get '/tweets' do
    if session[:id]
      @user = current_user
      erb :"/tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if signed_in?
      @user = current_user
      erb :"/tweets/create_tweet"
    else
      redirect("/login")
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      tweet = Tweet.new(user_id: session[:id], content: params["content"])
      tweet.save
      redirect("/tweets")
    else
      redirect("/tweets/new")
    end
  end

  get '/tweets/:id' do
    if signed_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect("/login")
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if signed_in?
      @user = current_user
      erb :"/tweets/edit_tweet"
    else
      redirect("/login")
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if !params["content"].empty?
      tweet.content = params["content"]
      tweet.save
    end
    redirect("/tweets/#{tweet.id}/edit")
  end

  delete '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if tweet.id == current_user.id
      tweet.delete
    end
    redirect("/tweets")
  end
end
