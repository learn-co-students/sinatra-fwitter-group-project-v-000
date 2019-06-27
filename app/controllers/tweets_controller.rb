require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to("/login")
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'/tweets/create_tweet'
    else
      redirect to("/login")
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to("/tweets/new")
    else
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.create(content: params[:content], user_id: @user.id)

      redirect to("/tweets/#{@tweet.id}")
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params["id"])

    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'/tweets/show_tweet'
    else
      redirect to("/login")
    end
  end

  get '/tweets/:id/edit' do

    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = User.find_by(id: session[:user_id])
      if @tweet && @tweet.user_id == @user.id
        erb :'/tweets/edit_tweet'
      else
        redirect to("/tweets")
      end
    else
    redirect to("/login")
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @user = User.find_by(id: session[:user_id])

    if !params[:content].empty? && @tweet.user_id == @user.id
      @tweet.content = params[:content]
      @tweet.save
    elsif params[:content].empty? && @tweet.user_id == @user.id
      redirect to("/tweets/#{@tweet.id}/edit")
    elsif !params[:content].empty? && @tweet.user_id != @user.id
      redirect to("/tweets")
    else
      redirect to("/login")
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @user = User.find_by(id: session[:user_id])

    if logged_in? && @tweet.user_id == @user.id
      @tweet.destroy

      redirect to("/tweets")
    else
      redirect to("/login")
    end
  end

end
