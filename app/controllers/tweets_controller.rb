class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = current_user
      erb :tweets
    else
      redirect to '/login'
    end
  end

  post "/tweets" do
    if params[:content] == ""
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(params)
      @tweet.user_id = session[:user_id]
      @tweet.save
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :'new'
    else
      redirect to '/login'
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweetshow'
    else
      redirect to '/login'
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      @tweet = Tweet.find(params[:id])
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end 
  end

end