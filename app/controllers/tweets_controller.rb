class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      erb :"tweets/show"
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    @user = User.find_by(session[:user_id])
    if !params["tweet"]["content"].empty?
      @tweet = Tweet.create(content: params["tweet"]["content"])
      @tweet.user = @user
      @tweet.save
    end
    redirect to "/tweets/#{@tweet.id}"
  end
end
