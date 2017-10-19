class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
    
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    redirect '/tweets/new' if params[:content].empty?
  
    if user = current_user
      Tweet.new(params).tap { |tweet| tweet.user = user }.save
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      
      if @tweet.user == current_user
        erb :'tweets/edit_tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find(params[:id])
      tweet.update(content: params[:content])
  
      redirect "tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])

    if tweet.user == current_user
      tweet.destroy

      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end
end