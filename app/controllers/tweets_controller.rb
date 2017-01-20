require 'pry'
class TweetsController < ApplicationController 

  get '/tweets' do 
    if logged_in?
      @tweets = Tweet.all
      @user = User.find_by_id(session[:user_id])

      erb :'/tweets/tweets'
    else  
      redirect to '/login'       
    end
  end 

  get '/tweets/new' do
    if logged_in? 
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end  
  end 

  post '/tweets' do
    if params[:content] == nil || params[:content] == "" || params[:user_id] == ""
      redirect to "/tweets/new"
    else       
      @tweet = Tweet.create(:content => params[:content], :user_id => params[:user_id])
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end
    
  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @user = User.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end    
  end   

  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if self.current_user.id == @tweet.user_id
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'  
      end
    else
      redirect to '/login'
    end 
  end

  patch '/tweets/:id' do 
    if logged_in?
      if @tweet.user_id == self.current_user.id
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to '/tweets'
      end  
    else 
      redirect to '/login'    
    end
  end  
  
  # patch '/tweets/:id' do
  #     erb :'/tweets/show_tweet'
  #   else 
  #     redirect to '/login'
  #   end    
  # end  

    #redirect "/tweets/#{@tweet.id}" 
   # redirect "/tweets/:id"

helpers do 

    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end   
  end  

end  








