class TweetsController < ApplicationController

  get '/tweets' do
    if User.find_by_id(session[:user_id])
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
#      @tweets = []
#      @tweets = Tweet.where(:user_id => @user.id) unless !Tweet.find_by(:user_id => @user.id)
      erb :'tweets/index'
    else
      redirect erb: '/login'
    end
  end

  get '/tweets/new' do
    if User.find_by_id(session[:user_id])
      erb :'tweets/new'
    else
      redirect erb: '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.new(:content => params[:content])
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect 'tweets'
    else
      redirect 'tweets/new'
    end
  end

  get '/tweets/:id' do
    if User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect 'login'
    end
  end

  get '/tweets/:id/edit' do
    if User.find_by_id(session[:user_id])
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    else
      redirect 'login'
    end
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      erb :'tweets/show'
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])

    if @tweet.user = User.find_by_id(session[:user_id])
      @tweet.delete
      redirect to '/tweets'
    else
      redirect 'login'
    end
  end

end
