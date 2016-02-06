require './config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do 
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
    if params[:username] == "" || params[:password] == "" || params[:email] == "" 
      redirect '/signup'
    else
      session[:id] = @user.id
      redirect '/tweets' 
    end
  end


  get '/login' do 
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do 
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/login'  #where should we redirect? a failure page, sign up, or login?
    end
  end 

  get '/tweets/new' do 

    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do   
    if params[:content] == "" #|| params[:content] == nil  #do we needs to account for nil too???
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content])  
      @user = current_user
      @tweet.user_id = @user.id 
      @tweet.save
      redirect '/tweets'
    end
   end

  get '/tweets' do 
    if logged_in?
      @user = current_user  #check on this later
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end  
  end

  get '/users/:slug' do 
    @user = User.find_by(username: params[:slug])
    erb :'/tweets/tweets'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if logged_in?
      erb :'/tweets/show_tweet' 
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do 
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end

  end

  post '/tweets/:id/edit' do 
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    # @user = current_user
    # @tweet.user_id = @user.id 
    
    redirect '/tweets'
  end 

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if session[:id] == @tweet.user.id 
      @tweet.delete
      redirect '/tweets'
    else 
      redirect '/login'
    end
    erb :'/tweets/show_tweet'
  end

  get '/logout' do 
    session.clear
    redirect '/login'
  end

  ## need to create two helper methods current_user and is_logged_in

  helpers do 
    def current_user
     User.find(session[:id])
    end
 
    def logged_in?
     !!session[:id]
    end
  end




end ## class end 















