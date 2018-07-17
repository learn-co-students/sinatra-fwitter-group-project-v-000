require './config/environment'

class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @current_user = User.find_by_id(session[:user_id])

      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @current_user = User.find_by_id(session[:user_id])

      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])

      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])

      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @current_user = User.find_by_id(session[:user_id])
      @current_user.tweets << Tweet.new(params)
      @current_user.save

      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      @tweet.save

      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @current_user = User.find_by_id(session[:user_id])
    @tweet = Tweet.find_by_id(params[:id])
    if @current_user.tweets.find_by_id(@tweet.id)
      @tweet.delete
    end
    redirect to '/tweets'
  end

end
