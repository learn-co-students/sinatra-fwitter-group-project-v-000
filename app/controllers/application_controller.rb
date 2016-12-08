require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end
  
  get '/' do
    erb :index
  end
  
  get '/signup' do
    if session[:id].nil?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end
  
  get '/login' do
    @user = User.find_by id: session[:user_id]
    if @user.nil?
      #binding.pry
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end
  
  get '/logout' do
    @user = User.find_by id: session[:user_id]
    if !@user.nil?
      redirect to '/login'
    else
      redirect to '/'
    end
    #binding.pry
  end
  
  get '/tweets' do
    #binding.pry
    @user = User.find_by id: session[:user_id]
    if !@user.nil?
      #binding.pry
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show_user_tweets'
  end
  
  get '/tweets/new' do
    @user = User.find_by id: session[:user_id]
    #binding.pry
    if !@user.nil?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:tweet_id' do
    if !session[:user_id].nil?
      @tweet = Tweet.find_by params[:tweet_id]
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
    #binding.pry
  end
  
  get '/tweets/:tweet_id/edit' do
    @user = User.find_by id: session[:user_id]
    if !@user.nil?
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
#    binding.pry
  end
 
  post '/signup' do
    #binding.pry
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect to '/signup'
    end
    @user = User.create(params)
    session[:id] = @user.id
    redirect to '/tweets'
  end
  
  patch'/login' do
    @user = User.find_by username: params[:user][:username]
    #binding.pry
    if !@user.nil? && @user.authenticate(params[:user][:password]) != false
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  post '/login' do
    @user = User.find_by username: params[:username]
    #binding.pry
    if !@user.nil? && @user.authenticate(params[:password]) != false
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end
  
  post '/tweets/new' do
    #@user = User.find_by username: params[:user]
    if !params[:content].empty?
      Tweet.create(params)
    else
      redirect to '/tweets/new'
    end
    #binding.pry
  end
  
  post '/tweets/change' do
    #binding.pry
    if !params[:content].empty?
     @tweet = Tweet.find(params[:tweet_id])
     @tweet.content = params[:content]
     @tweet.save
   else
     redirect to "/tweets/#{params[:tweet_id].to_i}/edit"
   end
  end
  
  post '/tweets/:id/delete' do
    Tweet.delete(params[:id])
    redirect to '/tweets'
    #binding.pry
  end

end