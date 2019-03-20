class TweetsController < ApplicationController

  get '/tweets' do
    unless !logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @user = current_user
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet=Tweet.create(content: params[:content], user: @user)
      redirect to "/users/#{@user.slug}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      unless params[:content].empty?
        Tweet.update(params[:id], content: params[:content])
        redirect to "/tweets/#{params[:id]}"
      else
        redirect to "/tweets/#{params[:id]}/edit"
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy if @tweet.user == current_user
    redirect to "/tweets"
  end

end
