
require "rack-flash"

class TweetsController < ApplicationController
  use Rack::Flash


  get '/tweets' do
     if logged_in?
        @tweets = Tweet.all
        erb :'/tweets/index'
     else
        redirect to '/users/login' # or /login
     end
   end

   get '/tweets/new' do
     if logged_in?
       erb :'/tweets/new'
     else
       redirect to "/users/login"
     end 
   end

   post '/tweets' do
     if params[:content] = ""
       redirect to "/tweets/new"
     else
       @user = User.find_by_id(session[:user_id])
       @tweet = Tweet.create(:content => params[:content])
     redirect to "/tweets/#{@tweet.id}"
     end
     # flash[:message] = "Successfully created tweet."
   end

   get '/tweets/:id' do
     if logged_in? && current_user
      binding.pry
          @tweet = Tweet.find(params[:id]) 
          erb :"/tweets/show"
      else
        redirect to :'/users/login'
      end 
   end

   get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id]) 
      if logged_in? and @tweet.user_id == session[:user_id]
            erb :'tweets/edit'
      else
        redirect to '/tweets'
      end 
   end

   patch '/tweets/:id' do
    if logged_in? && current_user
        params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit" 
    else
       @tweet = Tweet.find_by(params[:id])
       @tweet.content = params[:content]
       @tweet.save
       redirect to '/tweets/#{@tweet.id}'
     end 
   end

   delete '/tweets/:id/delete' do
     @tweet = Tweet.find_by(params[:id]) # or find_by_id
     if logged_in? and current_user
          @tweet.delete
          redirect to '/tweets'
     else
       redirect to "/tweets"
     end 
   end
end
