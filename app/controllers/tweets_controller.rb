require 'rack-flash'

class TweetsController < ApplicationController

  use Rack::Flash

  get '/tweets/new' do
    redirect to '/login' unless logged_in?

    erb :'tweets/create_tweet'
  end

  get '/tweets/:id' do
    redirect to '/login' unless logged_in?

    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    redirect to '/login' unless logged_in?

    @tweet = Tweet.find(params[:id])

    unless @tweet.user.id == current_user.id
      flash[:notice] = "You cannot edit another user's tweet!"
      redirect to "/tweets/#{@tweet.id}"
    end

    erb :'/tweets/edit_tweet'
  end

  get '/tweets' do
    redirect to '/login' unless logged_in?

    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: current_user.id)

    unless @tweet.save
      flash[:notice] = "Invalid tweet. Please try again."
      redirect to '/tweets/new'
    end

    redirect to "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    # ActiveRecord validation not triggering for some reason so checking manually instead. Pending.
    if params[:content].empty?
      flash[:notice] = "Invalid content. Please try again."
      redirect to "/tweets/#{@tweet.id}/edit"
    elsif @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy if @tweet.user.id == current_user.id

    redirect to '/tweets'
  end
  
end