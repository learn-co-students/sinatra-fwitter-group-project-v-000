require './config/environment'

class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @users = User.all
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/show'
    end
  end

  # NEED TO FIX the 2 routes below this note???
  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(user_id: current_user.id, content: params[:content])
      redirect "/tweets"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user != ""
      erb :'/tweets/show_user_tweets'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_single_tweet'
    end
  end

#  /////////////////////////////////////////////////////////
  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'/tweets/edit'
      else
        redirect '/tweets'
      end
    end
  end
  #  /////////////////////////////////////////////////////////

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
      end
      redirect '/tweets'
    end
  end

end
