class TweetsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect :"/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/create_tweet"
    else
        redirect :"/login"
    end
  end

  post "/tweets" do
    if params[:content] && params[:content] != ""
      tweet=Tweet.create(content: params[:content])
      current_user.tweets << tweet
      redirect :"/tweets"
    else
      redirect :"/tweets/new"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect :"/login"
    end
  end

end
