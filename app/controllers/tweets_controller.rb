class TweetsController < ApplicationController

get '/tweets' do
  @user = User.find_by(params[:id])
  @users = User.all
  erb :tweets
end

get '/tweets/new' do
  erb :'/tweets/new'
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
  @tweet = Tweet.find_by(params[:id])
  erb :'/tweets/show'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find_by(params[:id])
  erb :'/tweets/edit'
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

end
