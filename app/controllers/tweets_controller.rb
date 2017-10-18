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

  get '/tweets/:id' do
  @tweets = Tweet.find_by_id(params[:id])
  erb :'tweets/show'
  end

  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/new'
    else
    end
  end

  post '/tweets' do
    @tweets = Tweet.create(content: params[:conent])
  end


end
