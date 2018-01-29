class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/:slug/tweets' do
    @user = User.find(session[:user_id])
    @tweets = Tweet.all
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      user = User.find(session[:user_id])
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = User.find(session[:user_id])
    tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    if tweet.content != nil && tweet.content != ""
      tweet.save
      redirect "/#{@user.slug}/tweets"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      erb :'/users/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{tweet.id}/edit"
    else
      tweet.update(content: params[:content])
      redirect '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect '/tweets'
    elsif logged_in? && @tweet.user_id != session[:user_id]
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
