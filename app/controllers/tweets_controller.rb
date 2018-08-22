class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    tweet = Tweet.create(content: params["content"], user_id: session[:id])
    redirect to "/tweets"
  end

  get '/tweets' do

  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit'
  end
end
