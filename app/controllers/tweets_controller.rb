class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user_status = session[:user_id] ? "logged in" : "logged out"
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:tweet][:content] == ""
      redirect to "tweets/new"
    else
      @tweet = Tweet.new(params[:tweet])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect to "tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    if params[:tweet][:content].empty?
      redirect to "tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(params[:tweet])
    end
    erb :'tweets/show'
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @tweet.destroy if @tweet.user_id == current_user.id
    end
    redirect "/tweets"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
