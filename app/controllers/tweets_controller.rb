
require "rack-flash"

class TweetsController < ApplicationController
  use Rack::Flash

# read index
  get '/tweets' do
     if logged_in?
        @tweets = Tweet.all
        erb :'tweets/index'
     else
        redirect to '/login' # or /login
     end
  end
#problem: how to code that you only get your tweets? 

#create
 get '/tweets/new' do
   if logged_in?
     erb :'tweets/new'
   else 
     flash[:notice] = "You must new logged in to tweet!"
     redirect to "/login"
   end 
 end
# create/get data 
 post '/tweets' do
    if logged_in?
    
        if current_user && params[:content] != ""
           @user = User.find_by(username: params[:username])
           @tweet = current_user.tweets.create(:content => params[:content], :user_id => current_user.id)
           redirect to "users/#{current_user.username}"
        else
          flash[:notice] = "Tweets need content"
          redirect to "/tweets/new"
         end  
    else 
      flash[:notice] = "Login to tweet."
      redirect to "/login"
    end
 end

 get '/tweets/:id' do
    if !logged_in?
      flash[:notice] = "Log in to view a tweet!"
        redirect to "/login"
    else
     
      @tweet = Tweet.find_by(params[:user_id])
          erb :'tweets/show'
     end 
  end 
#update/form
 get '/tweets/:id/edit' do

    @tweets = Tweet.all.find_by(params[:user_id])
     if  logged_in? && @tweets
        if current_user.id = @tweets.user_id
            erb :"tweets/edit"
          # @tweets = Tweet.all.find_by(params[:user_id])  
        else
          redirect to :'/tweets'
        end 
     else
        redirect to "/login"
     end 
  end

#update/data
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
#if no content
     if logged_in? and params[:content] == ""
        redirect to "/tweets/#{@tweet.id}/edit" 
#if content and current user 
     elsif
        @tweet && current_user.id = @tweet.user_id
        redirect to "/tweets/#{@tweet.id}"
     else 
        redirect to "/login"
      end 
  end

  delete '/tweets/:id/' do
     #can't do loggedin and current user in one line...
     if logged_in?
        @tweet = Tweet.find_by(:id => params[:user_id]) # or find_by_id
        
        if @tweet && @tweet.user_id == current_user.id
            @tweet.delete
            redirect to '/'
        end 
     else
       redirect to "/"
     end 
   end
end
