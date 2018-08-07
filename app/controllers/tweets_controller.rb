class TweetsController < ApplicationController

get '/tweets/new' do
  erb :'/tweets/new'
end

get '/tweets' do
  @tweets = Tweet.all
  erb :'/tweets/index'
end

get '/tweets/:id' do
  @tweet = Tweet.find_by(id: params["id"])
  erb :'/tweets/show'
end

get '/tweets/:id/edit' do
  @tweet = Tweet.find_by(id: params["id"])
  erb :'/tweets/edit'
end

post '/tweets' do
  #binding.pry
  @tweet = Tweet.create(params[:tweet])
  redirect "/tweets"
end

end
