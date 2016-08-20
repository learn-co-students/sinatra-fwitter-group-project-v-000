class TweetsController < ApplicationController
   
   get '/tweets' do 
    if session[:user_id]
    @user = User.find(session[:user_id]) 
     @tweets = Tweet.all
     erb :'/tweets/tweets'
    else
    redirect '/login'
    end
  end

  get '/tweets/new' do
   if !!session[:user_id]
    @user = User.find(session[:user_id])
    erb :'/tweets/create_tweet'
   else 
    redirect '/users/login'
    end
  end

post '/tweets' do
   if !params[:content].empty?
    tweet = Tweet.create(content: params["content"])
    @current_user = User.find(session[:user_id])
    @current_user.tweets << tweet
    redirect  '/tweets/tweets'
  else
     redirect '/tweets/new'
   end

  end
  
  get '/tweets/:id' do
    if !!session[:user_id]
    tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  else
    redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      @tweet = Tweet.create_or_find_by_id(params [:id])
      if @tweet.user_id == session[:user_id]
         erb :'/tweets/edit_tweet'
      
      else
        redirect '/tweets'
      end
    else 
       redirect '/login'
     end
    
  end

  patch '/tweets/:id' do
    if !!session[:user_id]
   @user = User.find_by_id(params[:id])
   @tweet = Tweet.find_by_id(params[:id])
 end
end

delete '/tweets/:id/delete' do

  end
end