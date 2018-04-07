class TweetsController < ApplicationController
 
 get '/tweets' do #shows all tweets
  if logged_in?
   @tweets = Tweet.all
   erb :'/tweets/tweets'
  else
   redirect to '/login'
  end
 end
 
  get '/tweets/new' do #create a new tweet
   if logged_in?
    erb :'/tweets/create_tweet'
   else
    redirect to '/login'
   end
  end
  
  post '/tweets' do #create a new tweet
   if !params[:content].empty?
    @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
    redirect to "/tweets/#{@tweet.id}"
   else
    redirect to "/tweets/new"
   end
  end
  
 get '/tweets/:id' do #shows the tweet
  if logged_in?
   @tweet = Tweet.find_by_id(params[:id])
   erb :'/tweets/show_tweet'
  else
   redirect to '/login'
  end
 end
 
 get '/tweets/:id/edit' do
  @tweet = Tweet.find_by_id(params[:id])
  if session[:user_id] && @tweet.user_id == session[:user_id]
    erb :'/tweets/edit_tweet'
  else
    redirect '/login'
  end
 end
 
 patch '/tweets/:id/edit' do
  if !params[:content].empty?
   @tweet = Tweet.find_by_id(params[:id])
   @tweet.content = (params[:content])
   @tweet.save
   redirect to "/tweets/#{@tweet.id}"
  else
   redirect to "/tweets/#{@tweet.id}/edit"
  end
 end
  
  delete '/tweets/:id/delete' do
   @tweet = Tweet.find_by_id(params[:id])
   if session[:user_id] && @tweet.user_id == session[:user_id]
    @tweet.delete
    redirect to '/tweets'
   elsif 
    !logged_in?
    redirect to '/login'
   else
    redirect to '/tweets'
   end
 end
  
  
end