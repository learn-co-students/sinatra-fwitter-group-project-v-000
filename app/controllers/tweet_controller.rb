class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = User.find_by(sessions[:user_id])
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    erb :"tweets/create_tweet"
  end

  post '/tweets' do
    # binding.pry
    @tweet = Tweet.create(params)
    @tweet.user = User.find_by(session[:user_id])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])
    erb :"tweets/show_tweet"
  end

  get "/tweets/:id/edit" do
    @user = current_user
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && @tweet.users_tweet?(@user)
      erb :"/tweets/edit_tweet"
    elsif logged_in? && !@tweet.users_tweet?(@user)
      redirect "/tweets"
    else
      redirect "/"
    end
  end

  delete '/tweets/:id/delete' do
   @tweet = Tweet.find_by_id(params[:id])
   @tweet.delete
   redirect '/tweets'
 end

  helpers do
    def users_tweet?(user)
      user.id == self.user_id
    end
  end
end
