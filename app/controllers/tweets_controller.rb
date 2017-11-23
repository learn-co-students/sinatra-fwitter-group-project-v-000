class TweetsController < ApplicationController

use Rack::Flash

get "/tweets" do 
  if logged_in?
    erb :'/tweets/tweets'
  else
    redirect "/login"
  end
end


get '/tweets/new' do
  if logged_in?
    erb :'/tweets/create_tweet'
  else
    redirect "/login"
  end
end

post '/tweets' do
  if !params[:content].empty?
  current_user.tweets.create(params)
  redirect "/users/#{current_user.slug}"
  else
  flash[:message] = "Please enter text to create a new tweet."
  redirect '/tweets/new'
  end
end

get '/tweets/:id' do
  if logged_in?
  @tweet = Tweet.find(params[:id])
  erb :'tweets/show_tweet'
  else
    redirect '/login'
  end
end

get '/tweets/:id/edit' do
  if logged_in? && current_user.tweets.include?(Tweet.find(params[:id]))
   @tweet = Tweet.find(params[:id]) 
   erb :'tweets/edit_tweet'
  else
    flash[:message] = "Sorry, you can only edit your tweets."
    redirect '/login'
  end
end

patch '/tweets/:id' do
  if !params[:content].empty?
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content]) 
    redirect "/tweets/#{@tweet.id}"
  end
    redirect "/tweets/#{params[:id]}/edit"
end

delete '/tweets/:id/delete' do 
  if logged_in? && current_user.tweets.include?(Tweet.find(params[:id]))
  Tweet.find(params[:id]).destroy
  redirect '/tweets'
  else
    flash[:message] = "Sorry, you can only delete your tweets."
    redirect '/login'
  end
end


end