class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
    @user = current_user
    erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = current_user
    if logged_in?
    @tweets = Tweet.create(content: params[:content])
    @tweets.user_id = @user.id
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      binding.pry
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    erb :'tweets/edit'
  end

  post '/tweets/:id' do
  end


end
