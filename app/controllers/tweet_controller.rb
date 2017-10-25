class TweetController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = current_user
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

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.user_id
        erb :"/tweets/edit"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  post "/tweets/new" do
    if params[:content] == ""
      redirect "/tweets/new"
    end
    current_user.tweets << Tweet.new(content: params[:content])
    current_user.save
    redirect "/tweets"
  end

  patch "/tweets/:id/edit" do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:tweet][:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(params[:tweet])
    end
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] == @tweet.user_id
      @tweet.delete
      redirect "/tweets"
    else
      redirect "tweets"
    end
  end

end