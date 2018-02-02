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

  get '/tweets/:id/edit' do
    if is_logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  else
    redirect '/login'
  end
  end

  patch '/tweets/:id' do
    if params["content"].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params["content"])
    redirect "/tweets/#{@tweet.id}"
  end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user
    @tweet.destroy
    redirect '/tweets'
  else
    redirect '/tweets'
  end
  end
end
