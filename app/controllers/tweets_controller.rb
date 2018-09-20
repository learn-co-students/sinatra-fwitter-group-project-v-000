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
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content])
      @tweet.user = current_user
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      if @tweet && @tweet.user.id == current_user.id
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    end
  end
  
  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
