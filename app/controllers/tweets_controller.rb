class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id] == nil
      redirect '/login'
    else
      # @user = User.find(session[:user_id])
      @tweets =  Tweet.all
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if session[:user_id] == nil
      redirect '/login'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      # user = User.find(session[:user_id])
      Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if session[:user_id] == nil
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    redirect '/login' if session[:user_id] == nil
    @tweet = Tweet.find(params[:id])
    if session[:user_id] != @tweet.user_id
      redirect '/tweets'
    else
      erb :'tweets/edit'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    # redirect '/login' if session[:user_id] == nil
    @tweet = Tweet.find(params[:id])
    if session[:user_id] != @tweet.user_id
      redirect '/tweets'
    else
      @tweet.delete
      redirect '/tweets'
    end
  end


end
