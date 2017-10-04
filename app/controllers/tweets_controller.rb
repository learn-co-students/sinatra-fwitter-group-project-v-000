class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'/tweets/new'
    else
      redirect to '/users/login'
    end
  end

  post '/tweets' do
    if !params["content"].empty?
      @tweet = Tweet.create(content: params["content"])
      @user = User.find_by(id: session[:user_id])
      @tweet.user_id = @user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

   get '/tweets/:id' do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.find_by_id(params["id"])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by(id: params["id"])
      if @tweet.user_id = session[:user_id]
        erb :'/tweets/edit'
      else
        redirect "/tweets"
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params["id"])
    if session[:user_id]
      @user = User.find_by_id(@tweet.id)
      if @user.id == session[:user_id]
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params["id"])
    if !params["content"].empty?
      @tweet.content = params["content"]
      @tweet.save
      redirect to '/tweets'
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

end