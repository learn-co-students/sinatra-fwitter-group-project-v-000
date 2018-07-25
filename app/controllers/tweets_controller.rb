class TweetsController < ApplicationController

get '/tweets' do
  if logged_in?
  @user = User.find_by(params[:id])
  @users = User.all
  erb :tweets
else
  redirect '/login'
end
end

get '/tweets/new' do
  if logged_in?
  erb :'/tweets/new'
else
  redirect '/login'
end
end

post '/tweets' do
  @user = User.find_by(params[:id])
  if !params[:content].empty?
  @user.tweets << Tweet.create(params)
  @user.save
else
  redirect '/tweets/new'
end
end

get '/tweets/:id' do
  if logged_in?
  @tweet = Tweet.find_by(params[:id])
  erb :'/tweets/show'
else
  redirect '/login'
end
end

get '/tweets/:id/edit' do
  if logged_in?
  @tweet = Tweet.find_by(params[:id])
  erb :'/tweets/edit'
else
  redirect '/login'
end
end

post '/tweets/:id' do
  if !params[:content].empty?
  @tweet = Tweet.find_by(params[:id])
@tweet.update(params)
erb :'/tweets/show'
else
  redirect :'/tweets/1/edit'
end
end

delete '/tweets/:id/delete' do
  @tweet = Tweet.find_by(params[:id])
#  @user = User.find_by(params[:id])
  #if @user.logged_in && @user.tweets.include?(@tweet)
  @tweet.delete
redirect to '/tweets'
#end
end

end
