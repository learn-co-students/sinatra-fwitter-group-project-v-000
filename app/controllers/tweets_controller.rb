class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @title = "Fwitter"
      @tweets = Tweet.all
      @user = current_user
      erb :"tweets/index"
    else
      flash[:message] = "You must be logged in to view tweets."
     redirect to "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      @title = "Create Tweet"
      @user = current_user
      erb :"tweets/new"
    else
      flash[:message] = "You must be logged in to tweet."
      redirect to "/login"
    end
  end

  post "/tweets" do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @user = current_user
      @tweet = Tweet.create(content: params[:content], user_id: @user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show"
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
       erb :"tweets/edit"
      else
        redirect to "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete "/tweets/:id/delete" do
    tweet = Tweet.find_by_id(params[:id])
    if session[:user_id]
      tweet = Tweet.find_by_id(params[:id])
      if tweet.user_id == session[:user_id]
        tweet.delete
        redirect to "/tweets"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end
end
