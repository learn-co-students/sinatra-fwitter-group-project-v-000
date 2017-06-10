require './config/environment'

class TweetController < ApplicationController

  before do
    redirect to "/login" unless logged_in?
  end

  get "/tweets" do
    @tweets = Tweet.all
    erb :"/tweets/index"
  end

  get "/tweets/new" do
    erb :"/tweets/new"
  end

  post "/tweets" do
    redirect to "/tweets/new" if params[:content].empty?
    @tweet = Tweet.create(content: params[:content])
    current_user.tweets << @tweet
    @tweet.save ? (redirect to "/tweets") : (redirect to "/tweets/new")
  end

  get "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    erb :"tweets/show"
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/edit"
  end

  post "/tweets/:id" do
    redirect to "/tweets/#{params[:id]}/edit" if params[:content].empty?
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    redirect to "/tweets" unless current_user == @tweet.user 
    @tweet.delete
    redirect to "/tweets"
  end
end
