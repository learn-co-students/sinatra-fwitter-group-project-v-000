require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "secret"

    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !is_logged_in? 
      erb :signup
    else 
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params.values.include?("")
      redirect to '/signup'
    else
      @user = User.create(params)
      @user.save
      @session = session
      @session[:id] = @user.id
    
    redirect to '/tweets' if is_logged_in? && !params.values.empty?
    end

  end  

  get '/login' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      @session = session
      @session[:id] = @user.id
      redirect to '/tweets'
    else
      erb :login
    end
  end

  get '/tweets' do
    if is_logged_in?
      @user = current_user
      @tweets = Tweet.all
      #@tweets = @user.tweets
      erb :tweets
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do 
    @user = current_user
    @tweets = @user.tweets
    erb :'users/show'
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params.values.include?("")
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(params)
      @tweet.user_id = current_user.id
      @tweet.save
    redirect to '/tweets' if is_logged_in?
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do 
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if params[:content] != ""
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      erb :'/tweets/show'
    else
      redirect to "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete if current_user.id == @tweet.user_id
    erb :'/tweets/show'
  end


#Helper methods
helpers do
  def current_user
    User.find(session[:id])
  end

  def is_logged_in?
    true if session[:id]
  end
end

end

