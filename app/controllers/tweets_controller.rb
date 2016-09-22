require './config/environment'
require 'rack-flash'

class TweetsController < ApplicationController 

  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # the tweets index page
  # this appears to be the users homepage once they're signed in
  # can grab a users specific tweets - a user has many tweets
  get '/tweets' do 

      if current_user
        @user = current_user
        erb :'tweets/tweets'
      else
        flash[:message] = "You must be logged in"
        redirect to '/login'
      end
  end

   get '/tweets/new' do 
    @user = current_user

    if @user
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    @user = current_user

    if params[:content].empty?
      flash[:message] = "Cannot create an empty tweet!"
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content], user_id: @user.id)
      @tweet.save
      @user.tweets << @tweet 
      @user.save
      flash[:message] = "Tweet successfully created!"
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do 
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      flash[:message] = "You gotta login to see tweets!"
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do 

    if !logged_in?
      flash[:message] = "You gotta login to edit tweets!"
      redirect to '/login' 
    end

    @tweet = Tweet.find(params[:id])
    
    if @tweet.user_id == current_user.id
      erb :'tweets/edit_tweet'
    elsif current_user.id != @tweet.user_id
      flash[:message] = "You can't edit a tweet that you didnt create!"
      redirect to '/tweets'
    end
  end

  patch '/tweets/:id/edit' do
  
  @tweet = Tweet.find(params[:id])
  
   if params[:content].empty?
     flash[:message] = "You must enter content to edit!"
     redirect to "/tweets/#{@tweet.id}/edit" 
   end
    
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.content = params[:content]
      @tweet.save
      flash[:message] = "Successfully edited tweet."
      redirect to "/tweets"
    end 
  end

  delete '/tweets/:id/delete' do #delete action
   @tweet = Tweet.find(params[:id])
  if current_user.id == @tweet.user_id 
    @tweet.delete
    flash[:message] = "Tweet Sucessfully Deleted"
    redirect to '/tweets'
  else
    flash[:message] = "You can't delete what you didnt create!"
    redirect to '/tweets'  # need a flash message to say you cant delete something you didnt make
  end
end





end