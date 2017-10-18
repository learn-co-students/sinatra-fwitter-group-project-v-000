class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.logged_in?(session)
      @user = User.find(session[:user_id])
      @tweets = Tweet.all

      erb :'tweets/tweets'
    else
      redirect 'users/login'
    end
  end

  get '/users/:slug' do
    if @user = Helpers.current_user(session)
      @tweets = @user.tweets
  
      erb :'/users/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    end

    if user = Helpers.current_user(session)
      tweet = Tweet.new(params)
      tweet.user = user
      tweet.save
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do

    if Helpers.logged_in?(session)
      user = Helpers.current_user(session)
      @tweet = user.tweets.find(params[:id])
    
      erb :'tweets/edit_tweets'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find(params[:id])
      tweet.update(content: params[:content])
  
      redirect "tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])

    if tweet.user == Helpers.current_user(session)
      tweet.destroy

      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end
end