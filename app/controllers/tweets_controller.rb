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

end
