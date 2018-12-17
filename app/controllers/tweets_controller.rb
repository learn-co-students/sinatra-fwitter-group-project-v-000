class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in? && params[:content]!= ""
      @tweet = Tweet.find_by(params[:id])
      @tweet.update(:content => params[:content])
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end


  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(params)
      @user = User.find(session[:user_id])
      @tweet.user_id = @user.id
      @tweet.save

      redirect '/tweets'
    end
  end


end
