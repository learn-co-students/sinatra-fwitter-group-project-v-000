
class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if params[:content] == ""
      redirect "/tweets/new"
    else
      new_tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{new_tweet.id}"
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by(id: params[:id])

    if !logged_in?
      redirect "/login"
    elsif current_user.id == @tweet.user_id
      erb :"/tweets/edit_tweet"
    else
      redirect "/tweets"
    end
  end

  post "/tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])

    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find_by(id: params[:id])

    if !logged_in?
      redirect "/login"
    elsif current_user.id != @tweet.user_id
      redirect "/tweets"
    else
      @tweet.delete
      redirect "/tweets"
    end
  end

end
