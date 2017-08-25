class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      erb :"/tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = User.find(session[:user_id])
    if params[:content] != ""
      @user.tweets << Tweet.create(params)
      @user.save
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] && @tweet.user_id == session[:user_id]
      @tweet.destroy
    else
      redirect "/login"
    end
  end
end 
