require 'sinatra/base'
require 'rack-flash'
class TweetsController < ApplicationController

enable :sessions
use Rack::Flash
  #Create The Tweet - C
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

  #Show The Tweet - R

    get '/tweets' do
      @user = current_user

      erb :'/tweets/tweets'
    end

    get '/tweets/:id' do
      #the spec says to not let someone see a single tweet if not logged in, although that makes no sense in a real twitter situation
      #This is only needed for the spec because our ':id' is @tweet.id not @user.id
      if logged_in?
        @user = current_user
        @tweet = Tweet.find_by(id: params[:id])

        erb :'tweets/show_tweet'
      else
        redirect to "/login"
      end
    end

    #Edit the Tweet - U

    get '/tweets/:id/edit' do

      @tweet = Tweet.find_by(id: params[:id])
      if current_user != @tweet.user
        redirect '/tweets'
      else
      erb :'tweets/edit_tweet'
      end
    end

    post '/tweets/:id' do
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.update(content: params[:content])
      redirect to "tweets/:id"
    end

    #Delete Tweet - D

    post '/tweets/:id/delete' do
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete

      redirect to "/tweets"
    end
end
