class TweetController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      @user = current_user
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.new(params)
      @tweet.user = current_user
      if @tweet.save
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params["content"]
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
