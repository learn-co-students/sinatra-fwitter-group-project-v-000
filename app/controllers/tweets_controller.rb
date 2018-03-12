class TweetsController < ApplicationController

  get '/tweets' do
    if !session[:user_id]
      redirect to '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !session[:user_id]
      redirect to '/login'
    else
      erb :'/tweets/create_tweet'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      tweet = Tweet.create(content: params[:content])
      tweet.user_id = session[:user_id]
      tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if !session[:user_id]
      redirect to '/login'
    elsif session[:user_id] == @tweet.user_id
      erb :'/tweets/edit_tweet'
    else
      redirect to '/tweets'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if !session[:user_id]
      redirect to '/login'
    elsif session[:user_id] == @tweet.user_id
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end
end
