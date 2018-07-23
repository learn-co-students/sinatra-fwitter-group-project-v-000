class TweetsController < ApplicationController

  get '/tweets' do
    @user = User.find_by_id(session[:user_id])
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect :'/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :"/tweets/new"
    else
      redirect :login
    end
  end

  post "/tweets" do
    if !is_logged_in?
      redirect :login
    else
      if params[:content] != ""
        @tweet = Tweet.create(content: params[:content])
        current_user.tweets << @tweet
        redirect :"/tweets/#{@tweet.id}"
      else
        redirect :'/tweets/new'
      end
    end
  end

  get "/tweets/:id" do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show"
    else
      redirect :login
    end
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in? && @tweet.user_id == current_user.id
      erb :"/tweets/edit"
    else
      redirect :login
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
      if params[:content] == ""
        redirect :"/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
        redirect :"/tweets/#{@tweet.id}"
      end
    else
      redirect :login
    end
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id == @tweet.id && is_logged_in?
      @tweet.delete
      erb :"tweets/deleted"
    else
      redirect :login
    end
  end


end
