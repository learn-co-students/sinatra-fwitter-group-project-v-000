class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @username = current_user.username
      erb :"tweets/tweets"
    else
      flash[:notice] = "You must be logged in to view this page."
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      flash[:notice] = "You must be logged in to create a tweet."
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    if !logged_in?
      flash[:notice] = "You must be logged in to edit a tweet."
      redirect to "/login"  
    end
    @tweet = Tweet.find(params[:id])
    if @tweet && (@tweet.user_id == current_user.id)
      erb :"tweets/edit_tweet"
    else
      flash[:notice] = "You do not have permission to edit tweets you did not create."
      redirect to "/login"
    end
  end

  post "/tweets" do
    if params["content"].empty?
      flash[:notice] = "You did not enter any thoughts to create a tweet."
      redirect to "/tweets/new" 
    end
    @tweet = Tweet.new(content: params["content"], user_id:current_user.id)
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      erb :"tweets/show_tweet"
    else
      flash[:notice] = "You must be logged in to view this page."
      redirect to "/login"
    end
  end

  patch "/tweets/:id" do
    if params["content"].empty?
      flash[:notice] = "You did not enter any thoughts when editing the tweet."
      redirect to "/tweets/#{params[:id]}/edit" 
    end
    @tweet = Tweet.find(params[:id])
    if @tweet && (@tweet.user_id == current_user.id)
      @tweet.update(content: params["content"])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete "/tweets/:id/delete" do
    if !logged_in?
      flash[:notice] = "You must be logged in to delete a tweet."
      redirect to "/login"  
    end
    @tweet = Tweet.find(params[:id])
    if @tweet && (@tweet.user_id == current_user.id)
      @tweet.delete
      redirect to '/tweets'
    else
      flash[:notice] = "You do not have permission to delete tweets you did not create."
      redirect to "/login"
    end
  end

end
