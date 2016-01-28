class TweetController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweet/create_tweet' 
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    tweet = Tweet.new(:content => params[:content], :user_id => session[:id])
    if tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end    
  end

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      erb :'tweet/index' 
    else
      redirect "/login"
    end     
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      erb :'tweet/show_tweet'
    else
      redirect "/login"
    end   
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweet/edit_tweet'
    else
      redirect "/login"
    end   
  end

  patch '/tweets/:id' do
    if logged_in?
      tweet = Tweet.find(params[:id])
      tweet.content = (params[:content])
      if tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect "/tweets/#{tweet.id}/edit"
      end
    else
      redirect '/login' 
    end   
  end

  delete '/tweets/:id/delete' do 

    tweet = Tweet.find(params[:id])
    if tweet.user_id == session[:id]
      tweet.destroy
      redirect "/tweets"
    else
      redirect "/tweets/#{tweet.id}"
    end    
  end  
end  