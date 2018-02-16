class TweetsController < ApplicationController

  get '/tweets' do
    @user = User.find(session[:user_id]) if session[:user_id]
    if logged_in?
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if logged_in?
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect to "/tweets/#{tweet.id}/edit"
      # Have to interpolate here because it's not a get request from the client browser
    else
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    user = User.find(session[:user_id]) if session[:user_id]
    tweet = Tweet.find(params[:id])
    if !!user && tweet.user_id == user.id
      tweet.destroy
    end
  end

  get '/tweets/:id' do
    @user = User.find(session[:user_id]) if session[:user_id]
    @tweet = Tweet.find(params[:id])
    if !!@user
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(params)
    tweet.user_id = session[:user_id]
    tweet.save
    if tweet.content == "" # How do I write this solution without hard coding?
      redirect to '/tweets/new'
    else
      redirect to '/tweets'
    end
  end
end
