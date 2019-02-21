require 'pry'

class TweetsController < ApplicationController

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
  	  redirect to '/login'
    end
  end

  get '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
  	  @tweets = Tweet.all
      @user = Helpers.current_user(session)
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
  	  @tweet = Tweet.find_by_id(params[:id])
  	  erb	:'/tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save

      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == Helpers.current_user(session)
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets"
    end

      if !Helpers.is_logged_in?(session)
        redirect to '/login'
      else
    	  @tweet = Tweet.find_by_id(params[:id])
    	  erb	:'tweets/show_tweet'
      end
    end
  end
