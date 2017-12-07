class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
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

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = current_user.tweets.find_by_id(params[:id])
      if @tweet
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.create(content: params[:content]) unless params[:content].empty?
    if @tweet
      redirect "tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  patch '/tweets/:id' do
    @tweet = current_user.tweets.find_by_id(params[:id])
    if logged_in? && !params[:content].empty?
      @tweet.content = (params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = current_user.tweets.find_by_id(params[:id])
    if @tweet && logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end
end
