class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect "/"
    end
  end

  post '/tweets' do
    # binding.pry
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @user = User.find_by_id(session[:user_id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @user = current_user
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && @tweet.users_tweet?(@user) && !params[:content].empty?
      @tweet.update(params)
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
   @tweet = Tweet.find_by(params[:id])
   @tweet.delete
   redirect '/tweets'
 end

  helpers do
    def users_tweet?(user)
      user.id == self.user_id
    end
  end
end
