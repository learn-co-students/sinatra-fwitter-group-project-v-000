class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    #binding.pry
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        erb :"tweets/edit_tweet"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      #binding.pry
      erb :"tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    #binding.pry/
    if logged_in?
      current_user
      tweet = Tweet.new
      tweet.content = params[:tweet_content]
      tweet.user_id = @current_user.id
      if tweet.save
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet.update(:content => params[:tweet_content])
      redirect '/tweets'
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.user == current_user
      tweet.delete
    end
    tweet.delete
    redirect '/tweets'
  end
end
