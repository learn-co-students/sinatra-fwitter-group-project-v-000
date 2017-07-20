class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all.dup
      erb :'/tweets/index'
    else
      flash[:message] = "Please log in."
      redirect '/login'
    end

  end


  get '/tweets/new' do
    if session[:user_id]
      erb :'/tweets/new'
    else
      flash[:message] = "Please log in."
      redirect '/login'
    end
  end

  post '/tweets' do
    User.find(session[:user_id]).tap do |user|
      if params[:content].chars.any?
        user.tweets.create(content: params[:content])
        redirect "/tweets/#{user.tweets.last.id}"
      else
        flash[:message] = "You can't post an empty tweet!"
        redirect '/tweets/new'
      end
    end

  end


  get '/tweets/:id' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      flash[:message] = "Please log in."
      redirect '/login'
    end
  end


  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      flash[:message] = "Please log in."
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    Tweet.find(params[:id]).tap do |tweet|
      if params[:content].chars.any?
        tweet.update(content: params[:content])
        redirect "/tweets/#{tweet.id}"
      else
        flash[:message] = "You can't post an empty tweet!"
        redirect "/tweets/#{tweet.id}/edit"
      end

    end
  end


  delete '/tweets/:id' do
    if session[:user_id]
      user = User.find(session[:user_id])
      tweet = Tweet.find(params[:id])

      if user.tweets.include?(tweet)
        tweet.delete
        flash[:message] = "Tweet successfully baweeted."
        redirect '/tweets'
      else
        flash[:message] = "You can only baweet your own tweets."
        redirect "/tweets/#{tweet.id}"
      end

    else
      flash[:message] = "Please log in."
      redirect '/login'
    end

  end


end
