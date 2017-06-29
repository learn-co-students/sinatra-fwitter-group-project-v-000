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
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect("/login")
    end
  end

  get '/tweets/:id/edit' do

  end

  patch '/tweets/:id' do

  end

  delete '/tweets/:id' do

  end
end
