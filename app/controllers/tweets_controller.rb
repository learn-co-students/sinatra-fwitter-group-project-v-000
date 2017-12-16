class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
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
    if !logged_in?
      redirect '/login'
    elsif params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id = current_user.id
        erb :'/tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
