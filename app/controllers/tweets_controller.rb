class TweetsController < ApplicationController

  get "/tweets" do
    if !logged_in?
      redirect to "/login"
    end
    @tweets = Tweet.all
    @user = current_user
    erb :"/tweets/tweets"
  end

  get "/tweets/new" do
    if !logged_in?
      redirect to "/login"
    end
    erb :"/tweets/new"
  end

  post "/tweets" do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect to :"/tweets"
    else
      redirect to "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if !logged_in?
      redirect to "/login"
    end

    @user = current_user
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show"
  end

  get "/tweets/:id/edit" do
    if !logged_in?
      redirect to "/login"
    end
    @user = current_user
    @tweet = Tweet.find(params[:id])

    if @tweet.user_id != session[:user_id]
      redirect to "/tweets"
    end

    erb :"/tweets/edit"
  end

  patch "/tweets/:id" do
    @user = current_user
    @tweet = Tweet.find(params[:id])

    if @tweet.user_id != session[:user_id]
      redirect to "/tweets"
    end

    if @tweet.user_id = session[:user_id] && !params[:content].empty?
      @tweet.user_id = session[:user_id]
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets"
    else
      redirect to "/tweets/#{@user.id}/edit"
    end
  end

  post "/tweets/:id/delete" do
    if !logged_in?
      redirect to "/login"
    end

    @tweet = Tweet.find(params[:id])

    if @tweet.user_id != session[:user_id]
      redirect to "/tweets"
    end

    if @tweet.user_id = session[:user_id]
      @tweet.destroy
      redirect to "/tweets"
    end
  end

end
