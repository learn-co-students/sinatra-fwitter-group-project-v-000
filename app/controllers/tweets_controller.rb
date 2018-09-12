class TweetsController < ApplicationController

get '/tweets/new' do
  if logged_in?
    erb :'/tweets/new'
  else
    redirect '/login'
  end
end

get '/tweets' do
  @tweets = Tweet.all
  @user = User.find_by(id: session[:user_id])
  if logged_in?
    erb :'/tweets/index'
  else
    redirect '/login'
  end
end

get '/tweets/:id' do
  if logged_in?
    @tweet = Tweet.find_by(id: params["id"])
    erb :'/tweets/show'
  else
    redirect '/login'
  end
end

get '/tweets/:id/edit' do
  if logged_in?
    @tweet = Tweet.find_by(id: params["id"])
    erb :'/tweets/edit'
  else
    redirect '/login'
  end
end

post '/tweets' do
  if !params["content"].empty?
    @tweet = Tweet.create(content: params["content"], user_id: session["user_id"])
    redirect '/tweets'
  else
    redirect '/tweets/new'
  end
end


patch '/tweets/:id' do
  @tweet = Tweet.find_by(id: params["id"])
  if !params["content"].empty?
    @tweet.update(content: params["content"])
    redirect "/tweets/#{@tweet.id}"
  else
    redirect "/tweets/#{@tweet.id}/edit"
  end
end


delete '/tweets/:id/delete' do
  if logged_in?
    @tweet = Tweet.find_by(user_id: session["user_id"])
    @tweet.destroy
    redirect '/tweets'
  else
    redirect '/login'
  end
end

end
