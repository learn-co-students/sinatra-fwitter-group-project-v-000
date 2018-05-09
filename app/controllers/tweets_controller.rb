class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
    @user = current_user
    @tweets =  Tweet.all
    erb :'/tweets/tweets'
  else
    redirect "/login"
  end
end

  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/create_tweet'
  else
    redirect '/'
  end
end

  post '/tweets' do
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do

    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    #@user = current_user

    #if logged_in? && @tweet.users_tweet?(@user)
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
    erb :'/tweets/edit_tweet'
  #elsif logged_in? && !@tweet.users_tweet?(@user)
    #redirect '/tweets'
  else
    redirect '/login'
  end
end

  patch '/tweets/:id' do
    @user = current_user
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && @tweet.users_tweet?(@user) && !params[:content].empty?
      @tweet.update(params)
    redirect to "/tweets/#{@tweet.id}"
  end
  end

  delete '/tweets/:id/delete' do

    redirect to "/tweets"
  end


helpers do

  def users_tweet?(user)
    user.id == self.user_id
  end
end

end
