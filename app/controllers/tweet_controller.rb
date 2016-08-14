class TweetController < ApplicationController

  ### SHOW ALL TWEETS ###
  get '/tweets' do 
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else 
      redirect "/login"
    end
  end


### NEW TWEET ###
  get '/tweets/new' do
    if !!session[:user_id]
      user = User.find(session[:user_id])
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do
    if params[:content].empty?
      redirect "/tweets/new"
    else user = User.find(session[:user_id])
      tweet = Tweet.create(content: params[:content])
      user.tweets << tweet
      redirect "/tweets"
    end
  end

  ### SHOW TWEET ###
  get '/tweets/:tweet_id' do
    if !!session[:user_id]
      @tweet = Tweet.find(params[:tweet_id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  ### EDIT TWEET ###
  get '/tweets/:tweet_id/edit' do
    if !!session[:user_id]
      if session[:user_id] == Tweet.find(params[:tweet_id]).user.id
        @tweet = Tweet.find(params[:tweet_id])
        erb :'tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  post '/tweets/:tweet_id/edit' do
    if !params[:content].empty?
      tweet = Tweet.find(params[:tweet_id])
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets"
    else 
      redirect "/tweets/#{params[:tweet_id]}/edit"
    end
  end

  ### SHOW ALL TWEETS ###
  get '/:slug/tweets' do
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else 
      redirect "/login"
    end
  end


  ### DELETE A TWEET ###
  post "/tweets/:tweet_id/delete" do 
    if !!session[:user_id]
      if session[:user_id] == Tweet.find(params[:tweet_id]).user.id
        User.find(session[:user_id]).tweets.find(params[:tweet_id]).delete
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end


end