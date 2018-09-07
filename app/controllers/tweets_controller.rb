class TweetsController < ApplicationController
  configure do
  enable :sessions
  set :session_secret, "secret"
end

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else

    erb :'tweets/tweets'
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
  if params[:content] == ""
    redirect '/tweets/new'
  else
  @tweet = Tweet.new(content: params[:content])
  @tweet.user_id = session[:user_id]
  @tweet.save
end

end

get '/tweets/:id' do
  if logged_in?
  @tweet = Tweet.find_by(id: params[:id])
  erb :'/tweets/show_tweet'
else
  redirect '/login'
end
end

get '/tweets/:id/edit' do
  if logged_in?
  @tweet = Tweet.find_by_id(params[:id])
  erb :'/tweets/edit_tweet'
else
  redirect '/login'
end
end

post '/tweets/:id/edit' do
  @tweet = Tweet.find_by_id(params[:id])
  @tweet.update(content: params[:content])
end

post '/tweets/:id/delete' do
  
  @tweet = Tweet.find_by_id(params[:id])
  if logged_in? && current_user == @tweet.user 
  @tweet.delete
  redirect '/tweets'
else
  redirect '/login'
end
end






end
