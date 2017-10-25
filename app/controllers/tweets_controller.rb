class TweetsController < ApplicationController

  get('/tweets/show') {@user = current_user; erb :"tweets/show"}

  get('/tweets/new') {if logged_in?; erb :'/tweets/new' else redirect to "/login" end}

  post '/tweets' do
    @tweet = Tweet.create(content: params["content"], user_id: session[:user_id])
    if @tweet.save
      @user = current_user
      erb :'/tweets/index'
    else
      redirect to "tweets/new"
    end
  end

  get('/tweets/index'){@user = current_user; erb :"/tweets/index"}

  get '/tweets' do 
    if logged_in?
      @user = current_user
      erb :'/tweets/index'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.all.find_by_id(params[:id])
      erb :"/tweets/edit"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do 
    if logged_in?
      @user = current_user
      @tweet = Tweet.all.find_by_id(params[:id])
      erb :"tweets/show"
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.all.find_by_id(params[:id])
    @tweet.content = params["content"]
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.all.find_by_id(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
      end
    else
      redirect to "/login"
    end
    redirect to "/tweets/index"
  end
end