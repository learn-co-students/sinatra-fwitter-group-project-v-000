require 'rack-flash'

class TweetsController < ApplicationController
  use Rack::Flash

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      flash[:message] = "Must be logged in to view tweets."
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      flash[:message] = "Must be logged in to create a new tweet."
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content].empty?
      flash[:message] = "Tweet must have content."
      redirect "/tweets/new"
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      
      flash[:message] = "New tweet created!"
      redirect "/tweets"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      flash[:message] = "Must be logged in to view a tweet."
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in? && current_user.tweets.ids.include?(params[:id].to_i)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    elsif logged_in?
      flash[:message] = "You don't have permission to edit that tweet."
      redirect "/tweets"
    else
      flash[:message] = "Please log in."
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if logged_in? && current_user == @tweet.user
      if valid_params?
        @tweet.update(content: params[:content])
        redirect "/users/#{current_user.username.slugify}"
      else
        flash[:message] = "Invalid params"
        redirect "/tweets/#{params[:id]}/edit"
      end
    else
      flash[:message] = "You don't have permission to update this tweet."
      redirect "/tweets"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])

    if logged_in? && current_user.id == @tweet.user_id
      @tweet.destroy
      flash[:message] = "Tweet deleted."
      redirect "/users/#{@tweet.user.username.slugify}"
    else
      flash[:message] = "You don't have permission to delete this tweet."
      redirect "/tweets"
    end
  end

end
