class TweetsController < ApplicationController

  get "/tweets" do
    # binding.pry
    @tweets = Tweet.all
    if logged_in?
    erb :"tweets/tweets"
  else
    redirect to "/login"
    end
  end

  get "/tweets/new" do
    erb :"tweets/create_tweet"
  end

  post "/tweets" do
    @tweet = Tweet.create(content: params[:content])
    @tweet.user_id = User.find_by_id(session[:user_id])
    @tweet.save
    redirect to "/tweet/#{@tweet.id}"
  end

  get "/tweet/:id" do
    @tweet = Tweet.find_by_id(session[:user_id])
    erb :"tweets/show_tweet"

  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by_id(session[:user_id])
    erb :"tweets/edit_tweet"
  end

  post "/tweet/:id" do
   @tweet = Tweet.find_by_id(session[:user_id])
   @tweet.content = params[:content]
   @tweet.user_id = session[:user_id]
   @tweet.save
   redirect "/tweet/#{@tweet.id}"
  end

end
