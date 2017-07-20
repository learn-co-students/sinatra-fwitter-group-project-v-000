class TweetsController < ApplicationController

  get '/tweets' do
    if_logged_in do
      @tweets = Tweet.all.dup
      erb :'/tweets/index'
    end
  end


  get '/tweets/new' do
    if_logged_in do
      erb :'/tweets/new'
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
    if_logged_in do
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    end
  end


  get '/tweets/:id/edit' do
    if_logged_in do

      user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id])

      if user.tweets.include?(@tweet)
        erb :'/tweets/edit'
      else
        flash[:message] = "You can only edit your own tweets!"
        redirect "/tweets/#{@tweet.id}"
      end

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
    if_logged_in do

      user = User.find(session[:user_id])
      tweet = Tweet.find(params[:id])

      if user.tweets.include?(tweet)
        tweet.delete
        flash[:message] = "Tweet successfully baweeted."
        redirect '/tweets'
      else
        flash[:message] = "You can only baweet your own tweets!"
        redirect "/tweets/#{tweet.id}"
      end

    end
  end


end
