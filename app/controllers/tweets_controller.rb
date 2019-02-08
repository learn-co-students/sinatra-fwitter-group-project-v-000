class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect "/login"
    else
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect "/login"
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect "/login"
    else
      @user = current_user
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit_tweet'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
    end
    redirect "/tweets"
  end

end
