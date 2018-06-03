class TweetController < ApplicationController 
  
  get '/tweets' do
    check_logged_in
    @user = current_user
    
    erb :'tweets/tweets'
  end 
  
  get '/tweets/new' do 
    check_logged_in
    @user = current_user
    
    erb :'/tweets/create_tweet'
  end 
  
  get '/tweets/:id' do 
    check_logged_in
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user if @tweet.user == current_user
       
    erb :'tweets/show_tweet'
  end 
  
  get '/tweets/:id/edit' do
    check_logged_in
    @tweet = Tweet.find(params[:id])
    
    redirect "/tweets" if @tweet.user != current_user
    
    @user = @tweet.user
    erb :'tweets/edit_tweet'
  end 
  
  post '/tweets' do 
    redirect '/tweets/new' if !valid_tweet? 
       
    Tweet.create(content: params[:content], user_id: params[:user_id])
    @user = current_user
    
    erb :'tweets/tweets'
  end 
  
  patch '/tweets/:id' do
    redirect "/tweets/#{params[:id]}/edit" if !valid_tweet?
    
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save 
    @user = @tweet.user 
    
    erb :'/tweets/show_tweet'
  end 
  
  delete '/tweets/:id/delete' do
    check_logged_in
    @tweet = Tweet.find(params[:id])
    @tweet.destroy if current_user == @tweet.user 
      
    redirect '/tweets'  
  end 
  
  helpers do 
    def valid_tweet?
      params.values.all?{ |v| !v.empty? }
    end 
  end 
  
end 