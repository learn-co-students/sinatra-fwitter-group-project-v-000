class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] != ""
      @tweet = Tweet.create(params)
      @tweet.user_id = current_user.id
      @tweet.save
      # redirect '/tweets/#{@tweet.id}'
    end
  end


  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
  # binding.pry
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect '/tweets'
    end
  end


end
