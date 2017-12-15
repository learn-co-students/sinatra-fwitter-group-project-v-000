
require "rack-flash"

class TweetsController < ApplicationController
  use Rack::Flash


  get '/tweets' do
     if logged_in?
        @tweets = Tweet.all
        erb :'/tweets/index'
     else
        redirect to '/login' # or /login
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
     if logged_in?
        if params[:content] = ""
           redirect to "/tweets/new"
        else
          @user = User.find_by_id(session[:user_id])
          @tweet = Tweet.create(:content => params[:content])
           # get "/users/#{user.slug}"
           redirect to "/tweets/#{@tweet.id}"
        end
     else 
        redirect to "/tweets/new"
     end 
     # flash[:message] = "Successfully created tweet."
   end

   get '/tweets/:id' do
     if logged_in?
          @tweets = Tweet.all.find_by(params[:id]) 
          erb :"/tweets//show"
      else
        redirect to :'/users/login'
      end 
   end

   get '/tweets/:id/edit' do
   
      if logged_in?
         @tweet = Tweet.find_by(params[:id]) 
         if @tweet.user_id== current_user.id
            erb :'tweets/edit'
         else
          redirect to '/tweets'
        end
      else
        redirect to '/login'
      end 
   end

   patch '/tweets/:id' do
    if logged_in? 
        if params[:content] == ""
            redirect to "/tweets/#{params[:id]}/edit" 
        else
           @tweet = Tweet.find_by(params[:id])
      
           @tweet.content = params[:content]
           @tweet.save
           redirect to '/tweets/#{@tweet.id}'
         end 
    else 
        redirect to "/tweets/"
     end
   end

   delete '/tweets/:id/delete' do
     #can't do loggedin and current user in one line...
     if logged_in?
      @tweet = Tweet.find_by(params[:id]) # or find_by_id
      if @tweet.user_id == current_user.id
          @tweet.delete
          redirect to '/tweets'
        else
          redirect to '/tweets'
        end 
     else
       redirect to "/tweets"
     end 
   end
end
