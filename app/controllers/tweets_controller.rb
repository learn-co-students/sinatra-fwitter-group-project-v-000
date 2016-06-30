require 'rack-flash'

class TweetsController < ApplicationController
  use Rack::Flash

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if !logged_in?
      redirect to '/login'
    elsif
      @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect to '/tweets'
    end
  end

end
