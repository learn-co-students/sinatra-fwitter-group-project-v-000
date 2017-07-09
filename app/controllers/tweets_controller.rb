class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      flash[:message] = "Please log in to view the tweets."
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      flash[:message] = "Please log in to create tweets."
      redirect '/login'
    end
  end

  post '/tweets' do
    # binding.pry
    if !params[:content].empty?
      current_user.tweets.create(params)
      redirect '/tweets'
    else
      flash[:message] = "Cannot create empty tweet!!"
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      flash[:message] = "Please log in to view tweet."
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      flash[:message] = "Please log in to view tweet."
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.user == current_user
      # binding.pry
      if !params[:content].empty?
        tweet.update(:content=>params[:content])
        redirect "/tweets/#{tweet.id}"
      else
        flash[:message] = "Content cannot be empty."
        redirect "/tweets/#{tweet.id}/edit"
      end
    else
      flash[:message] = "Insufficient privileges to edit!"
      redirect '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    # binding.pry
    tweet = Tweet.find(params[:id])
    if logged_in? && tweet.user == current_user
      tweet.delete
    end
    redirect '/tweets'
  end

end
