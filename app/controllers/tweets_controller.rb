require 'pry'
class TweetController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = current_user
      erb :"/posts/index"
    else
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/posts/new"
    else
      redirect to "/login"
    end
  end

  post "/tweet" do
    if params[:content] != ""
      tweet = Tweet.new(content: params[:content])
      tweet.user_id = current_user.id
      tweet.save
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/posts/show"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/posts/edit"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] != "" && current_user.id == @tweet.user_id
      @tweet.update(content: params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
      redirect to '/tweets'
    end
  end

end
