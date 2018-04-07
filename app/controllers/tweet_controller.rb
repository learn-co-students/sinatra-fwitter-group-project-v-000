class TweetController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/users/login"
    end
  end

  post "/tweets" do
    tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    redirect "/tweets"
  end

  get "/tweets/new" do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'tweets/create_tweet'
    else
      redirect "/users/login"
    end
  end

end
