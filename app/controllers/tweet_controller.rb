class TweetController < ApplicationController
  include Authable::InstanceMethods

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get 'tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets' do

  end

  delete '/tweets/:id/delete' do

  end
end
