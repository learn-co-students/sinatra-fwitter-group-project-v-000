require 'rack-flash'
class TweetsController < ApplicationController

use Rack::Flash

  get '/tweets' do
  	if logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
  		erb :'/tweets/tweets'
  	else
  		redirect "/login"
  	end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content] == ""
      flash[:message] = "A tweet cannot be empty. Please fill in some content."
      redirect '/tweets/new'
    else
      @user = User.find_by_id(session[:user_id])
      @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
      @tweet.save
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if logged_in? && current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
       flash[:message] = "A tweet cannot be empty. Please fill in some content."
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
    end
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == current_user
        erb :'/tweets/edit_tweet'
      end
    else
      redirect '/login'
    end
  end
    
  delete '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.destroy
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
end