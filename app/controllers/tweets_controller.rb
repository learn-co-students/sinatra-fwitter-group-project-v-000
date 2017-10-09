class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do
      @user = current_user
      if !params[:content].empty?
        @tweet = Tweet.create(content: params[:content], user_id: @user.id)
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/new"
      end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user == @tweet.user
        erb :'tweets/edit_tweet'
      end
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id/edit' do
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect "/tweets"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user == @tweet.user
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
