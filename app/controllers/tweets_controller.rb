class TweetsController < ApplicationController

  get '/tweets' do
    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/index'
    else
      redirect erb: '/'
    end
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

  post '/tweets' do
    @tweet = Tweet.new(params)
    @tweet.save
    redirect 'tweets/#{@tweet.id}'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save

    erb :'tweets/show'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect to '/tweets'
  end

end
