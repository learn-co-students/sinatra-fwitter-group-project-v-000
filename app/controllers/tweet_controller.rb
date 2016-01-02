class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if missing_field?
      erb :'tweets/new_tweet', locals: {missing_field: "Please enter a tweet."}
    else
      @user = User.find(session[:user_id])
      @user.tweets.create(params[:data])
      redirect "/tweets/#{@user.tweets.last.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect 'login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
     @tweet = Tweet.find(params[:id])
     erb :'tweets/edit_tweet'
    else
      redirect 'login'
    end
  end

  post '/tweets/:id' do
    if content_unchanged?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet', locals: {content_unchanged: "Please change the content of your tweet."}
    else
      if logged_in?
        @tweet = Tweet.find(params[:id])
        @tweet.update(params[:data])
        redirect "/users/#{User.find(session[:user_id]).slug}"
      end
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
