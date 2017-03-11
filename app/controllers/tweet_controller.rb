require './config/environment'

class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
	    redirect '/login'
    end
	end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
	    redirect '/login'
    end
	end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
	    redirect '/login'
    end
	end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
	    redirect '/login'
    end
	end

  post '/tweets' do
    tweet = Tweet.create(user_id: session[:user_id], content: params[:content])
    redirect '/tweets/new'
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      if tweet.user_id == session[:user_id]
        tweet.delete
      end
      redirect '/tweets'
    else
	    redirect '/login'
    end
	end

end
