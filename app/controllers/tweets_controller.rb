class TweetsController < ApplicationController

  get '/tweets' do
    redirect '/login' unless session[:current_user]
    @tweets = Tweet.all
    erb :'/tweets/index' 
  end

  get '/tweets/new' do
    if session[:current_user]
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    redirect '/tweets/new' if params[:content].empty?
    tweet = Tweet.new
    tweet.content = params[:content]
    session[:current_user].tweets << tweet
    tweet.save
    redirect "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    not_logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    not_logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end

  patch '/tweets/:id' do
    redirect "/tweets/#{params[:id]}/edit" if params[:content].empty?
    tweet = Tweet.find(params[:id])
    tweet.content = params[:content]
    tweet.save
    redirect '/tweets'
  end

  delete '/tweets/:id' do
    not_logged_in?
    tweet = Tweet.find(params[:id])
    tweet.destroy if session[:current_user].tweets.include?(tweet)
    redirect '/tweets' 
  end









end