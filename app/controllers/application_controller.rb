require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 
   
    erb :index
  end 


  get '/login' do 
    if !is_logged_in?
        erb :'users/login'
    else 
      redirect '/tweets'
    end 
  end 

  # post '/login' do 
  #   redirect '/login'
  # end 

  get '/signup' do 
    
      if is_logged_in?
          redirect '/tweets'
      else 
      erb :'users/create_user'
    end 
  end

  post '/signup' do 
   
      if params[:username].present? && params[:email].present? && params[:password].present?
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        session[:user_id] = @user.id
      
        redirect '/tweets'
      else 
        redirect '/signup'
      
    end 
  end 

  get '/tweets' do 
 
    if is_logged_in?
        @fweets = Tweet.all
        @posts = []
        @fweets.each do |f|
        @posts << {username: User.find(f.user_id).username, content: f.content, user_id: f.user_id, id: f.id}
          end
      @user = User.find(session[:user_id])
      erb :'tweets/tweets' 
    else
     redirect '/login'
    end 
  end 

  get '/tweets/new' do 
      if is_logged_in?
        erb :'/tweets/create_tweet'
      else 
        redirect "/login"
    end
  end 

  post '/tweets/new' do 
   if !params[:tweet].present?
    redirect '/tweets/new'
  end 

    if is_logged_in? && params[:tweet].present?
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(content: params[:tweet], user_id: @user.id)
      redirect '/tweets'
    else
      redirect '/login'
    end 
  end 


  post '/login' do
    @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
              session[:user_id] = @user.id
        redirect '/tweets'
      else 
      erb :'/users/login'
    end 
  end 

  get '/tweets/:id' do 
   
      if is_logged_in?
        @tweet = Tweet.find(params[:id])
     
        erb :'/tweets/one_tweet'
      else 
        redirect '/login'
      end
    end

  get '/logout' do 
    session.clear 
    redirect '/login'
  end 

  get '/users/:slug' do 
    
    @user = User.find_by(username: params[:slug])
      @fweets = Tweet.where(user_id: @user.id)
      erb :'/tweets/show_tweet'
  end 


  get '/tweets/:id/edit' do 
    if is_logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  else 
      redirect '/login'
    end 
  end 

  post '/tweets/:id/edit' do 
    
  if params[:tweet].present?
    @tweet= Tweet.find(params[:id])
    @tweet.update(content: params[:tweet])

    redirect '/tweets'
  else 
    redirect "/tweets/#{@tweet.id}/edit"
  end 
  end


  get '/tweet/:id/delete' do 
  
    Tweet.find(params[:id]).delete

    redirect '/tweets'
  end 

  post '/tweet/:id/delete' do 
      @tweet = Tweet.find(params[:id])

    redirect "/tweet/#{@tweet.id}/delete"
  end 


  
  helpers do 

    def current_user
      User.find(session["user_id"])
    end 

    def is_logged_in?
       !!session[:user_id]
    end
  end

end