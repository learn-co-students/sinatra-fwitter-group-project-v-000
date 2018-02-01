require 'pry'
class TweetController < ApplicationController


  get '/tweets' do
    if is_logged_in?
      @user = current_user
    #binding.pry
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/show' do
    if params["content"].empty?
      redirect '/tweets/new'
    else
    @tweet = Tweet.create(content: params["content"], user_id: session[:user_id])
    redirect "/tweets/#{@tweet.id}"
  end
  end

  get '/tweets/:id' do
    if is_logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  else
    redirect '/login'
  end
end

  get '/tweets/:id/delete' do
  #  if session[:user_id] = @tweet.user.id
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect '/tweets'
  #else redir
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params["content"])
    redirect "/tweets/#{@tweet.id}"
  end
end
