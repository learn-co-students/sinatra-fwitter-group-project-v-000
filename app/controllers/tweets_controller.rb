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
    redirect '/login'
  end
end

  post '/tweets' do
    if !params[:content].empty?
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  else
    redirect '/tweets/new'
  end
  end

  get '/tweets/:id' do
    if logged_in?
    @tweet = Tweet.find_by(params[:id])
    @user = current_user
    erb :'/tweets/show_tweet'
  else
    redirect '/login'
  end
end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
    erb :'/tweets/edit_tweet'
  else
    redirect '/login'
  end
end

  patch '/tweets/:id' do
    @user = current_user
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && users_tweet?(@user, @tweet) && !params[:content].empty?
      @tweet.update(:content => params[:content])
      @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  elsif params[:content] == ""
    redirect "tweets/#{@tweet.id}/edit"
  else
  end
end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(params[:id])
    @tweet.delete
    redirect to "/tweets"
  end


helpers do

  def users_tweet?(user, tweet)
    user.id == tweet.user_id
  end
end

end
