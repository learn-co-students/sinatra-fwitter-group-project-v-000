class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/test' do
    @user = User.find_by_id(session[:user_id])
    @tweets = Tweet.all
    erb :'users/show'
  end

  get '/edit' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/edit_tweet'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/new' do
    if !logged_in?
      redirect '/login'
    elsif
      params[:content].empty?
      redirect '/tweets/new'
    else
      @user = current_user
      @user.tweets.build(content: params[:content])
      @user.save
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to "/login"
    else
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    end
  end

  patch '/tweets/:id/edit' do
    tweet = Tweet.find(params[:id])
    tweet.content = params[:content]
    tweet.save
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    if logged_in? && tweet.user_id == current_user.id
      tweet.delete
    end
      redirect to '/tweets'
  end

end
