class TweetsController < ApplicationController

  get "/tweets/new" do
    if !!session[:id]
      erb :"/tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if params[:content].empty?
      redirect :"tweets/new"
    else
      @tweet = Tweet.create(params)
      @tweet.user_id = User.find(session[:id]).id
      @tweet.save
      erb :"/tweets/tweets"
    end
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by(id: params[:id])
    erb :"/tweets/edit_tweet"
  end

  get "/tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])
    erb :"/tweets/show_tweet"
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find_by(id: params[:id])
      # change name/whatever according to params
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  delete "/tweets/:id/delete" do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.clear
  end


end
