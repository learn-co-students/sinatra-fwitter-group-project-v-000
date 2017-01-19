require 'pry'
class TweetsController < ApplicationController 

  get '/tweets/new' do
    if logged_in? 
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end  
  end

  get '/tweets' do 
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else  
      redirect to '/login'       
    end
  end  

  get '/tweets/:slug' do 
    @tweet = Tweet.find_by(:id => params[:id])
    
    erb :'/tweets/show_tweet'
  end

  # get '/tweet/:id/edit' do 

  # end
  
  # patch '/tweets/:id' do 

  #   erb :'/tweets/show_tweet'
  # end

  post '/tweets' do 
    @tweet = Tweet.create(:content => params[:content], :user_id => params[:user_id])
    redirect :'/tweets/#{@tweet.slug}'
  end   

helpers do 

    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end   
  end  

end  








