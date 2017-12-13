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

end
