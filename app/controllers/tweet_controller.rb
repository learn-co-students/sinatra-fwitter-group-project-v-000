class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @users = User.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
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
    if params[:content] != ""
      @tweet = current_user.tweets.create(content: params[:content])
      redirect "tweets"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      redirect "tweets/#{@tweet.id}"
    else
      redirect "tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end