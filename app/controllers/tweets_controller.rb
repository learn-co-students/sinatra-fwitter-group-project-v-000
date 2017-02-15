class TweetsController < ApplicationController

  # INDEX
  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      flash[:message] = "You must log in to access tweets."
      redirect to '/login'
    end
  end

  # CREATE TWEET
  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet = current_user.tweets.create(content: params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # EDIT
  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id] #check the tweet's user id
         erb :'/tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  # DELETE
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect to '/tweets'
      end
    else
      redirect to '/tweets'
    end
  end
end
