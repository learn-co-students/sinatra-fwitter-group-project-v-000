class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @username = current_user.username
      erb :"tweets/tweets"
    else
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    redirect to "/login" if !logged_in? 
    @tweet = Tweet.find(params[:id])
    if @tweet && (@tweet.user_id == current_user.id)
      erb :"tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  post "/tweets" do
    redirect to "/tweets/new" if params["content"].empty?
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
      redirect to "/login"
    end
  end

  patch "/tweets/:id" do
    redirect to "/tweets/#{params[:id]}/edit" if params["content"].empty?
    @tweet = Tweet.find(params[:id])
    if @tweet && (@tweet.user_id == current_user.id)
      @tweet.update(content: params["content"])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete "/tweets/:id/delete" do
    redirect to "/login" if !logged_in? 
    @tweet = Tweet.find(params[:id])
    if @tweet && (@tweet.user_id == current_user.id)
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to "/login"
    end
  end

end
