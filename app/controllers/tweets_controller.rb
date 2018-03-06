class TweetsController < ApplicationController

   get '/tweets' do
  #  binding.pry
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
       redirect '/login'
    end
    
  end

  get '/logout' do
    # binding.pry
    if logged_in?
      session.clear
      redirect 'login' 
    else
     redirect '/'
    end
  end

  get '/tweets/new' do
    if logged_in?
       erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    # binding.pry
    if logged_in?
      @user = current_user
      @content = params[:content]
      # binding.pry
      if @content != ""
         @tweet = Tweet.create(content: @content, user_id: current_user.id)
         erb :'/tweets/show_tweet'
      end
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id' do
  # binding.pry
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.content != ""
        erb :'/tweets/show_tweet'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
     if logged_in? && current_user
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      # binding.pry
       erb :'/tweets/edit_tweet'
    else
       redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    # binding.pry
    if logged_in? && current_user
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      # binding.pry # @tweet = Tweet.find_or_create_by(content: params[:content])
       erb :'/tweets/show_tweet'
    else
       redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      
    # binding.pry
      @tweet.delete
    
    end
  end

end