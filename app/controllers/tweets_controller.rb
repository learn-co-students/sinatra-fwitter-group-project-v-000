class TweetsController < ApplicationController

  get '/tweets' do
    # @user = User.find_by(params)
    if logged_in?
     erb :"/tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    erb :"/tweets/new"
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    @tweet.user_id = current_user.id
    @tweet.save

    redirect "/tweets"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @user = User.find_by_id(@tweet.user_id)
    erb :"/tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :"tweets/edit_tweet"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  delete "/tweets/:id" do
    Tweet.destroy(params[:id])
    redirect "/tweets"
  end


end
