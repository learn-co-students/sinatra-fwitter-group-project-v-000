require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do

    if logged_in?
      @tweets = Tweet.all
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    #binding.pry
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    #binding.pry

    if !params[:content].empty? && logged_in?
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
#binding.pry
      redirect "/tweets/#{@tweet.id}"
    elsif !logged_in?
      redirect '/login'
    elsif params[:content].empty?
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if Tweet.find_by_id(params[:id]) && Tweet.find_by_id(params[:id]).user_id == session[:user_id] && logged_in?
      @tweet = Tweet.find_by_id(params[:id])

      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Tweet.find_by_id(params[:id]) && Tweet.find_by_id(params[:id]).user_id == session[:user_id] && logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    elsif !logged_in?
      redirect '/login'
    elsif !Tweet.find_by_id(params[:id]) || !Tweet.find_by_id(params[:id]).user_id == session[:user_id]
      redirect '/tweets'
    end
  end

  patch '/tweets/:id' do

    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    elsif !Tweet.all.find_by_id(params[:id]).user_id == session[:user_id]
      redirect "/login"
    elsif !params[:content].empty? && Tweet.all.find_by_id(params[:id]).user_id == session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete 'tweets/:id/delete' do
    binding.pry
    if Tweet.all.find_by_id(params[:id]) && Tweet.find_by_id(params[:id]).user_id == session[:user_id] && logged_in?
      Tweet.all.find_by_id(params[:id]).delete
    end
      redirect '/tweets'
  end
end
