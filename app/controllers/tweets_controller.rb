class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    tweet = Tweet.new(params[:tweet])
    tweet.user = current_user
    if tweet.save
      redirect "/tweets"
    else
      erb redirect "/tweets/new"
    end
  end

  get "/tweets/:id" do
    @tweet = Tweet.find(params[:id])

    if logged_in?
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && @tweet.user == current_user
      erb :"tweets/edit"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])

    if params[:tweet][:content].strip != ""
      @tweet.update(params[:tweet])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id" do
    tweet = Tweet.find(params[:id])
    if tweet.user == current_user
      tweet.destroy
    end
    redirect "/tweets"
  end

end
