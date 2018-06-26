class TweetsController < ApplicationController

  before do
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect to '/login'
    end
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/index'
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    redirect to '/tweets/new' if params[:content].empty?
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    erb :'/tweets/show'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end

  patch '/tweets/:id' do
    redirect to "/tweets/#{params[:id]}/edit" if params[:content].empty?
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect to "/tweets/#{@tweet.id}" if @tweet.user_id != session[:user_id]
    @tweet.destroy
  end

end
