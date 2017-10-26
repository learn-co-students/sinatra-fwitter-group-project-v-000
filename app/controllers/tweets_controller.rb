class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all

    if logged_in?
      @user = current_user
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

    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
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
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && @tweet.user == current_user
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && session[:user_id] == @tweet.user_id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

end
