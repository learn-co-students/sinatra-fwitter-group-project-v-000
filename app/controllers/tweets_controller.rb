class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/twitter/index'
    else
      redirect to "/users/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'twitter/new'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'twitter/show'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'twitter/edit'
    end
  end

  post '/tweets/new' do
    unless params[:content] == ""
      @tweet = Tweet.create(params)

      redirect '/tweets'
    end
    redirect "/tweets/new"
  end

  delete '/tweets/:id/delete' do
    if logged_in && current_user == Tweet.find(params[:id]).user_id
      @tweet = Tweet.find(params[:id])
      @tweet.delete

      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  patch '/tweets/:id/edit' do
    if logged_in?
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
    else
      redirect "/login"
    end
  end


end
