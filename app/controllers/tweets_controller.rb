require 'sinatra/base'
require 'rack-flash'
class TweetsController < ApplicationController

enable :sessions
use Rack::Flash


#We were missing a index of ALL tweets I think ? (not just the users) I threw it in here.

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
    erb :'tweets/index'
      else redirect to "/login"
    end
  end



  #Create The Tweet - C -------------
    get '/tweets/new' do
      if logged_in?
      erb :'tweets/create_tweet'
      else
        flash[:message] = "Please log in to write a tweet."

        redirect to '/login'
      end
    end

    post '/tweets' do
      if !params[:content].empty?
        @tweet = Tweet.new(content: params[:content])
        @tweet.save
        @user = current_user
        @user.tweets << @tweet
        redirect to "/tweets/#{@tweet.id}"
      else
        flash[:message] = "Please write something to post!"
        redirect to "/tweets/new"
      end
    end

  #Show The Tweet - R -----------------------

    get '/tweets' do
      @user = current_user

      erb :'/tweets/tweets'
    end

    get '/tweets/:id' do
      # -----#the spec says to not let someone see a single tweet if not logged in, although that makes no sense in a real twitter situation
      # -----#This is only needed for the spec because our ':id' is @tweet.id not @user.id
      if logged_in?
        @user = current_user
        @tweet = Tweet.find_by(id: params[:id])

        erb :'tweets/show_tweet'
      else
        redirect to "/login"
      end
    end

    #Edit the Tweet - U -------------------------

    get '/tweets/:id/edit' do
      
      @tweet = Tweet.find_by(id: params[:id])
    
      if logged_in?
        erb :'tweets/edit_tweet'
      else
        redirect '/login'    
      end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find_by_id(params[:id])
      if logged_in? && !params["content"].empty?
        @tweet.update(content: params[:content])
        @tweet.save
        
      else 
        redirect to "/tweets/1/edit"
      end
    end

    #Delete Tweet - D -----------------------------

    delete '/tweets/:id/delete' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
       
        
        if @tweet.user_id == current_user.id
          @tweet.delete
          redirect to "/tweets"
        end
      else
        redirect '/login'
      end
    end


end