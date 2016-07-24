class TweetsController < ApplicationController

  get "/tweets" do
    if is_logged_in?
      erb :'tweets/index'
    else
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    if is_logged_in?
      erb :'tweets/new'
    else
      redirect to "/login"
    end
  end

  post "/tweets" do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect to "/tweets"
    else
      redirect to "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
      redirect to "/tweets"
    else
      redirect to "/tweets/#{@tweet.id}"
    end
  end



end
