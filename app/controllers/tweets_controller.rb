
require "rack-flash"

class TweetsController < ApplicationController
  use Rack::Flash


  get '/tweets' do
     if is_logged_in?
        @tweets = Tweets.all
        erb :'/tweets/index'
     else
        redirect to '/users/login'
     end
   end


   get '/tweets/new' do
     if is_logged_in?
       erb :"/tweets/new"
     else
       redirect to "/users/login"
     end 
   end

   post '/tweets' do
     if params[:content] = ""
       redirect to "/tweets/new"
     else
       @tweet = Tweet.new(params[:content])
     redirect to "/tweets"
     end
     # flash[:message] = "Successfully created tweet."
   end

   get '/tweets/:id' do
     @tweet = Tweet.find(params[:id]) 
     erb :"/tweets/show"
   end

   get '/tweets/:id/edit' do
     @tweet = Tweet.find(params[:id]) 

     erb :"/tweets/edit"
   end

   patch '/tweets/:id' do
     @tweet = Tweet.find(params[:id])
     @tweet.update(params[:content])

     redirect "/tweets/#{@tweet.id}"
   end

   delete '/tweets/:id/delete' do
     @tweet = Tweet.find(params[:id]) # or find_by_id
     @tweet.destroy  #diff between .destroy and .delete
     redirect to "/tweets"
   end
end
