class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect 'login'
    else
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect 'users/login'
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets/new' do
    @tweet = Tweet.create(content: params[:content])
    @user = User.find_by_id(session[:user_id])
    @tweet.user = @user
    if @tweet.save

      erb :'/tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save

    erb :'tweets/show_tweet'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])


    if @user == @tweet.user
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

end
