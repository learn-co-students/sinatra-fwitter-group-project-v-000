class TweetsController < ApplicationController

require 'pry'

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to "/login"
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else 
      @user = current_user #sets @user to session[:user_id]
      @tweet = Tweet.create(content: params[:content], user: @user) #creates a new Tweet using params and @user and sets it to @tweet
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in? 
      @user = current_user #check this********
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do  #load edit form
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit' 
    else 
      redirect to "/login"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    if params[:content] != ""
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else 
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

   delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.id == current_user.id
        @tweet.delete
        redirect to "/tweets"
      else 
      redirect to "/tweets"
      end
    end
  end
  
end