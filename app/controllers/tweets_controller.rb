class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect to "/login"
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to "/login"
    end
  end
  
  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.new(content: params[:content])
      @tweet.user = current_user
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect to "/login"
    end
  end
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      erb :'tweets/edit'
    elsif logged_in?
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/login"
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end
  
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      @tweet.delete
      redirect to '/tweets'
    elsif logged_in?
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/login'
    end
  end
end
