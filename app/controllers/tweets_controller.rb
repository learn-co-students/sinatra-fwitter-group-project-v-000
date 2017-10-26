class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/tweets/create_tweet'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save
    redirect to "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find_by(params[:id])
      if current_user.id == @tweet.user_id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to "/tweets"
      end
    end
  end

end
