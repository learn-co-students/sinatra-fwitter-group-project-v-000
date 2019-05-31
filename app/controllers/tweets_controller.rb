class TweetsController < ApplicationController

  get '/tweets' do
    # binding.pry
    if logged_in?
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    # binding.pry
      if params[:content] != ""
        # binding.pry
        @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
        erb :'/tweets/show_tweet'
      else
        redirect "/tweets/new"
      end
    end

    get '/tweets/:id' do
      if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
      else
        redirect "/login"
      end
    end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      if !params[:content].empty? && current_user.tweets.include?(@tweet)
        @tweet.update(content: params[:content])
        erb :'/tweets/show_tweet'
      else
        redirect "/tweets/#{params[:id]}/edit"
      end
    else
      redirect 'login'
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/login"
    end
  end




end
