require 'rack-flash'

class TweetsController < ApplicationController
  use Rack::Flash

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      flash[:message] = "You must be logged in to see this page."
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      flash[:message] = "You must be logged in to see this page."
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(params)
    if logged_in? && tweet.save
      current_user.tweets << tweet
      flash[:message] = "Successfully created tweet."
      redirect to "/tweets/#{tweet.id}"
    else
      flash[:message] = "Tweet failed. Please try again. Remember to fill in all fields."
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      flash[:message] = "You must be logged in to see this page."
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      flash[:message] = "Unable to update tweet. Please try again."
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      flash[:message] = "Successfully updated tweet."
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.id == @tweet.user_id
        erb :'/tweets/edit_tweet'
      end
    else
      flash[:message] = "You must be logged in to view this page."
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == @tweet.user_id
      @tweet.destroy
      flash[:message] = "Tweet successfully deleted."
      redirect to "/users/#{current_user.slug}"
    else
      flash[:message] = "You cannot delete someone else's tweet."
      redirect to '/tweets'
    end
  end

end
