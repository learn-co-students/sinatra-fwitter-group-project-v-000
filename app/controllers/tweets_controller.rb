class TweetsController < ApplicationController
  
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.all 
      erb :"/tweets/tweets"
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
    if logged_in?
      if params[:content].empty?
        redirect to '/tweets/new'
      else
        @tweet = Tweet.create(content: params[:tweet][:content]) 
        redirect to '/tweets/#{@tweet.id}'
      end
    else
      redirect to '/login'
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
     if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(params[:tweet])
    @tweet.save
    redirect to '/tweets/#{@tweet.id}'
  end
  
  delete '/tweets/:id/delete' do
    if @user.logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
  
end
