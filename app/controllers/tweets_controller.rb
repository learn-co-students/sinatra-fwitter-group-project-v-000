class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do

  end

  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.create(params)
      if @tweet.save
        @tweet = current_user.tweets.create(content: params[:content])
        flash[:notice] = "Successfully posted a new tweet."
        redirect '/tweets'
      else
        flash[:error] = @tweet.errors.full_messages
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

end
