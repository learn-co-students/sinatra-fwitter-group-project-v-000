class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    user = current_user
    tweet = Tweet.create(params)
    tweet.user = user
    if tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        erb :'tweets/edit'
      else
        "You are not allowed to edit tweets that are not your own"
      end
    else
      redirect '/login'
    end
  end

  put '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        if @tweet.update(params[:tweet])
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/#{@tweet.id}/edit"
        end
      else
        "You are not allowed to edit tweets that are not your own"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      if tweet.user == current_user
        tweet.destroy
        redirect '/tweets'
      else
        "You are not allowed to delete tweets that are not your own"
      end
    else
      redirect '/login'
    end
  end

end
