class TweetsController < ApplicationController
    
  get '/tweets/new' do
    if logged_in
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in
      @user = current_user
      
      if params[:content].length <= 140
        
        @tweet = Tweet.new(content: params[:content], user_id: @user.id)
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
        
      else
        redirect to "/tweets/new"
      end
      
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in
      @user = current_user
      @tweet = Tweet.find(params[:id])
      
      if @user.tweets.include?(@tweet)
        erb :'/tweets/edit'
      else
        redirect to "/tweets/#{@tweet.id}"
      end
      
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    if logged_in
      @user = current_user
      @tweet = Tweet.find(params[:id])
      
      if @user.tweets.include?(@tweet)
        @tweet.content = params[:content]
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/#{@tweet.id}/edit"
        end
      else
        redirect to "/tweets/#{@tweet.id}"
      end
      
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    if logged_in
      @user = current_user
      @tweet = Tweet.find(params[:id])
      if @user.tweets.include?(@tweet)
        @tweet.destroy
        redirect to "/tweets"
      else
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end
  
end