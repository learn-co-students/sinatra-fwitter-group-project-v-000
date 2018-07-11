# require 'rack-flash'

class TweetsController < ApplicationController

  get "/tweets" do 
    if logged_in?
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end
  end
  
  get "/tweets/new" do 
    if logged_in?
      erb :'/tweets/create_tweet'
    else 
      redirect '/login'
    end
  end
  
  
  post "/tweets" do 
    user = current_user
    if !params[:content].empty?
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect "/tweets"
    else
      redirect '/tweets/new'
    end
  end
  
  
  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else 
      redirect '/login'
    end
  end
  

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else 
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    if !params[:content].empty? 
      tweet = Tweet.find(params[:id])
      tweet.update(params)
      redirect "/tweets"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end
  
  
  
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in && current_user(session).id != @tweet.user_id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
  

end