class TweetController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      @tweet = Tweet.new(content: params[:content], user: current_user)
      @tweet.save
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @match = @tweet.user_id == session[:id]
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do 
    if !logged_in?
      redirect '/login'
    end
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:id]
      erb :'tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  post '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if @tweet.update(content: params[:content])
      redirect '/tweets'
    else  
      redirect "tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do 
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:id]
      @tweet.delete
    end
    redirect '/tweets'
  end

end