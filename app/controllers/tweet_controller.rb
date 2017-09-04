class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = current_user
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @user.tweets.build(content: params[:content])
      @user.save
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user
      @tweet.delete
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user == current_user && !params[:content].empty?
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end

  end

end
