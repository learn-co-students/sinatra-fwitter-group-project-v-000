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
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content], user_id: @user.id)
      @tweet.save
      @user.tweets << @tweet 
      @user.save
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do 
    if logged_in?
      @user = current_user
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do 
    redirect to '/login' if !logged_in?

    @tweet = Tweet.find(params[:id])
    
    if @tweet.user_id == current_user.id
      erb :'tweets/edit_tweet'
    elsif current_user.id != @tweet.user_id
      redirect to '/tweets'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    redirect to "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets"
    end 
  end

  # needs logic that allows me to 
  # make sure the tweet id belongs to the logged 
  # user 
  delete '/tweets/:id/delete' do #delete action
   @tweet = Tweet.find(params[:id])
  if current_user.id == @tweet.user_id 
    @tweet.delete
    redirect to '/tweets'
  else
    redirect to '/tweets'  # need a flash message to say you cant delete something you didnt make
  end
end





end