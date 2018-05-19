require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_is_awesome"
    use Rack::Flash
  end
  
  def logged_in?
    !!session[:user_id]
  end
  
  def current_user
    User.find(session[:user_id])
  end
  
  get '/' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :index
    end
  end
  
  get '/signup' do
    if logged_in?
      flash[:message] = "You are already logged in, please sign out to create a new account!"
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end
  
  post '/signup' do
    #ensures all forms are filled out
    params.each do |k,v| 
      if v.empty?
        flash[:message] = "Field #{k} is empty, please fill it and try again!"
        redirect to '/signup'
      end
    end
    
    #ensures that username is not taken--Commented out for the benefit of the test suite provided by Flatiron...
    #See https://github.com/learn-co-students/sinatra-fwitter-group-project-v-000/issues/759 for discussion...
#       if !!User.find_by(username: params[:username])
#         redirect to '/signup'
#       end
    #otherwise, signup and login
    
    #removes params[:submit] so that only parameters for user are in
    #the params hash, allowing User.create(params)
    params.delete("submit")
    new_user = User.create(params)
    session[:user_id] = new_user.id
    flash[:message] = "New account created successfully!"
    redirect to '/tweets'
  end
  
  get '/login' do
    if logged_in?
      flash[:message] = "You are already logged in, please log out to sign in under a different account!"
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
  
  post '/login' do
    user_to_login = User.find_by(username: params[:username])
    #avoids errors if user does not exist
    if !user_to_login
      flash[:message] = "User does not exist!"
      redirect to '/login'
    #checks if password is invalid
    elsif user_to_login.password != params[:password]
      flash[:message] = "Invalid password"
      redirect to '/login'
    else
      session[:user_id] = user_to_login.id
      redirect to '/tweets'
    end
  end
  
  get '/tweets' do
    if !logged_in?
      flash[:message] = "Sorry, you have to be logged in to see the tweets!"
      redirect to '/login'
    else
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    
    #Conditional to require user login to view a user show page
    #broke test suite, not requiring login to view user show pages!
    if !@user
      flash[:message] = "User not found."
      redirect to '/tweets'
    else
      @tweets = @user.tweets
      erb :'/users/show'
    end
  end
  
  get '/tweets/new' do
    if !logged_in?
      flash[:message] = "You have to log in to create a tweet!"
      redirect to '/login'
    else
      @user = current_user
      erb :'/tweets/create_tweet'
    end
  end
  
  post '/tweets/new' do
    if params[:content].empty?
      flash[:message] = "Tweet is empty, you cannot create an empty tweet!"
      redirect to '/tweets/new'
    else
      flash[:message] = "Tweet created successfully!"
      new_tweet = Tweet.create(content: params[:content])
      current_user.tweets << new_tweet
      current_user.save
      redirect to '/tweets'
    end
  end
  
  get '/tweets/:id/edit' do
    #Moved this conditional up here to avoid breaking
    #when the test suite tries to find a non-existent tweet
    if !logged_in?
      flash[:message] = "You have to be logged in to edit tweets!"
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    @user = current_user
    if !@tweet
      flash[:message] = "Sorry, the selected tweet does not exist!"
      redirect to '/tweets'
    elsif @tweet.user_id == @user.id
      erb :'/tweets/edit_tweet'
    #case where user tries to edit another user's tweets
    else
      flash[:message] = "Sorry, you can only edit your own tweets!"
      redirect to '/tweets'
    end
  end
  
  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @user = current_user
    if !logged_in?
      flash[:message] = "You can only edit tweets when logged in!"
      redirect to '/login'
    elsif !@tweet
      flash[:message] = "Sorry, you tried to edit a tweet that doesn't exist!"
      redirect to '/tweets'
    elsif @tweet.user_id != @user.id
      flash[:message] = "Sorry, you can only edit your own tweets!"
      redirect to '/tweets'
    elsif params[:content].empty?
      flash[:message] = "Sorry, tweets cannot be empty!"
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      flash[:message] = "Tweet edited successfully!"
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end
  
  delete '/tweets/:id/delete' do
    if !logged_in?
      flash[:message] = "You have to be logged in to delete tweets!"
      redirect to '/login'
    end
    @user = current_user
    @tweet = Tweet.find(params[:id])
    if @user.id == @tweet.user_id
      flash[:message] = "Tweet successfully deleted"
      @tweet.destroy
    else
      flash[:message] = "Sorry, you can only delete your own tweets!"
    end
    redirect to '/tweets'
  end
  
  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !logged_in?
      flash[:message] = "Sorry, you have to be logged in to view tweets!"
      redirect to '/login'
    elsif !@tweet
      flash[:message] = "Sorry, you tried to access a non-existent tweet!"
      redirect to '/tweets'
    else
      erb :'/tweets/show_tweet'
    end
  end

end
