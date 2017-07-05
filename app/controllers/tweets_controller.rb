class TweetsController < ApplicationController
  use Rack::Flash

  get "/tweets" do
    if logged_in?
      @current_user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      flash[:message] = "login before editing tweets"
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      @user_id = session[:user_id]
      erb :"/tweets/create_tweet"
    else
      flash[:message] = "login before editing tweets"
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if !@tweet.nil?
        @user_owns_tweet = current_user_owns_tweet?(@tweet)
        erb :"/tweets/show_tweet"
      else
        flash[:message] = "no such tweet exists"
        redirect "/tweets"
      end
    else
      flash[:message] = "login before editing tweets"
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if(!@tweet.nil?)
        if(current_user_owns_tweet?(@tweet))
          erb :"/tweets/edit_tweet"
        else
          flash[:message] = "the tweet does not belong to the user"
          redirect "/tweets"
        end
      else
        flash[:message] = "no such tweet exists"
        redirect "/tweets"
      end
    else
      flash[:message] = "login before editing tweets"
      redirect "/login"
    end
  end

  post "/tweets" do
    if logged_in?
      if(!params[:content].empty?)
        tweet = User.find_by(id: session[:user_id]).tweets.create(params)
        redirect "/tweets/#{tweet.id}"
      else
        flash[:message] = "error empty content"
        redirect "/tweets/new"
      end
    end
  end

  patch "/tweets/:id" do
    if logged_in?
      if(!params[:content].empty?)
        tweet = Tweet.find_by(id: params[:id])
        if(!tweet.nil?)
          if current_user_owns_tweet?(tweet)
            tweet.update(content: params[:content])
            redirect "/tweets/#{tweet.id}"
          end
        else
          flash[:message] = "no such tweet exists"
          redirect "/tweets"
        end
      else
        flash[:message] = "error empty content"
        redirect "/tweets/#{params[:id]}/edit"
      end
    end
  end

  delete "/tweets/:id" do
    if logged_in?
      tweet = Tweet.find_by(id: params[:id])
      if(!tweet.nil?)
        if current_user_owns_tweet?(tweet)
          tweet.delete
          redirect "/tweets"
        else
          flash[:message] = "the tweet does not belong to this user account"
          redirect "/login"
        end
      else
        flash[:message] = "no such tweet exists"
        redirect "/tweets"
      end
    else
      flash[:message] = "Login Please"
      redirect "/login"
    end
  end
end
