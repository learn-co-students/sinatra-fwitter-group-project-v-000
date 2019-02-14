class TweetsController < ApplicationController

  get '/tweets' do
    if session["user_id"] != nil
    @user = User.find(session["user_id"])
    erb :'/tweets/tweets'
    else
    redirect '/login'
    end
  end


get '/tweets/new' do
  if session["user_id"] != nil
  @user = User.find(session["user_id"])
  erb :'tweets/new'
  else
    redirect '/login'
  end
end

post '/tweets' do
  if params[:content] != ""
tweet = Tweet.create(:user_id => params[:user_id], :content => params[:content])
redirect "/tweets/#{tweet.id}"
  else
  redirect 'tweets/new'
  end
end

get '/tweets/:id/edit' do
  if session["user_id"] == nil
    redirect "/login"
  end
  @tweet = Tweet.find(params[:id])
  if session["user_id"] == @tweet.user_id
    erb :'/tweets/edit_tweet'
  else
    redirect "/login"
  end
end

patch '/tweets/:id' do
@tweet = Tweet.find(params[:id])

  if params[:content] != ""
@tweet.content = params[:content]
@tweet.save
redirect "/tweets/#{@tweet.id}"
  else
    redirect "/tweets/#{@tweet.id}/edit"
  end
end

get '/tweets/:id/delete' do
  @tweet = Tweet.find(params[:id])
  if session["user_id"] == @tweet.user_id
    @tweet.destroy
    redirect "/tweets"
  else
    redirect "/tweets"
  end
end

delete '/tweets/:id/delete' do
  @tweet = Tweet.find(params[:id])
  if session["user_id"] == @tweet.user_id
  @tweet.destroy
  redirect '/tweets'
else
  redirect '/login'
end
end


get '/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  @rights = 0
  if session["user_id"] != nil
    @rights = 1
    erb :'/tweets/show_tweet'
  else
  redirect :'/login'
  end
end






end
