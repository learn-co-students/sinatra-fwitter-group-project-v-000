class TweetsController < ApplicationController
  get '/tweets' do
    @tweets = Tweet.all
    if !logged_in?
      redirect '/login'
    else
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'/tweets/create_tweet'
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
    @tweet = Tweet.find(params[:id])
    if logged_in?
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        erb :"/tweets/edit_tweet"
      else
        redirect "/tweets"
      end
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      if @tweet.user_id == current_user.id
        @tweet.destroy
        redirect "/tweets"
      else
        redirect "/login"
      end
    else
      redirect '/login'
    end
  end
end
