require './config/environment'

class TweetController < ApplicationController
  
    get '/tweets' do
    #binding.pry
    @user = User.find_by id: session[:id]
    #if !@user.nil?
    if !current_user.nil?
      #binding.pry
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/new' do
    @user = User.find_by id: session[:id]
    #binding.pry
    if !@user.nil?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:tweet_id' do
    if !session[:id].nil?
      @tweet = Tweet.find_by params[:tweet_id]
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
    #binding.pry
  end
  
  get '/tweets/:tweet_id/edit' do
    #binding.pry
    @user = User.find_by id: session[:id]
    if !@user.nil?
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
#    binding.pry
  end
 
  post '/tweets/new' do
    if !params[:content].empty?
      @user = User.find_by params[:user_id]
      Tweet.create(params)
      #binding.pry
      erb :'/tweets/show_user_tweets'
    else
      redirect to '/tweets/new'
    end
    #binding.pry
  end
  
  post '/tweets/change' do
    #binding.pry
    if !params[:content].empty?
     @tweet = Tweet.find(params[:tweet_id])
     @tweet.content = params[:content]
     @tweet.save
     redirect to '/tweets'
   else
     redirect to "/tweets/#{params[:tweet_id].to_i}/edit"
   end
  end
  
  post '/tweets/:id/delete' do
    Tweet.delete(params[:id])
    redirect to '/tweets'
    #binding.pry
  end
 
end