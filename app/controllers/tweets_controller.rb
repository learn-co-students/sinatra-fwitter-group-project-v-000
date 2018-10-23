class TweetsController < ApplicationController
  
  get '/tweets' do 
    if logged_in?
      @tweets = Tweet.all 
      erb :'tweets/tweets'
      
    else
      redirect to '/login'
    end 
  end 
  
  get '/tweets/new' do 
    if logged_in?
      erb :'tweets/new'
      
    else 
      redirect to '/login'
    end 
  end 
  
  post '/tweets' do 
    if params[:content] = ""
      redirect to '/tweets/new'
      
    else 
      @tweet = Tweet.new(:content => params[:content])
      @tweet.save 
      session[:user_id] = @user.id 
      redirect to '/tweets/show_tweet'
    end 
  end 
  
  

end
