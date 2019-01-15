class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = User.find(session[:user_id])

      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    content = params[:content]

    if content.empty?
      redirect "/tweets/new"
    else
      tweet = Tweet.create(content: content)
      user = User.find(session[:user_id])

      user.tweets << tweet
      user.save

      redirect "/tweets/#{tweet.id}"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])

      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    erb :"/tweets/edit_tweet"
  end

  patch "/tweets/:id" do

  end

  delete "/tweets/:id/delete" do
    if logged_in?
      tweet = Tweet.find(params[:id])

      if tweet.user_id == session[:user_id]
        Tweet.delete(params[:id])

        redirect "/tweets"
      else
        redirect "/tweets/#{params[:id]}"
      end
    else
      redirect "/login"
    end
  end

end
