require './config/environment'

class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = current_user.tweets.create(content: params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end


  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

end
