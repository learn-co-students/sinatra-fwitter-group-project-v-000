require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do 
    erb :index
  end

  get '/logout' do
    if is_logged_in?(session)
      session.clear
      redirect '/users/login'
    else
      redirect '/'
    end
  end


  #users signup section

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do

    if params[:username] == ""
      redirect '/users/signup'
    elsif params[:password] == ""
      redirect '/users/signup'
    elsif params[:email] == ""
      redirect '/users/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      if @user.save
        session[:user_id] = @user.id
        redirect '/tweets/tweets'
      else
        redirect '/users/signin'
      end
    end

  end

  #LOGIN

  get '/login' do
    redirect '/tweets/tweets'if is_logged_in?
    erb :'/users/login'

  end

  post '/login' do
    @user = User.find_by(username:  params[:username])
    if params[:username] == "" || params[:password] == ""
      redirect '/users/login'
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets/tweets'
    else
      redirect '/users/login'
    end
  end


  get '/users/:slug' do

    @user = User.find_by_slug(params[:slug])

    erb :'/tweets/show'
  end

  #TWEETS

  get '/tweets' do 
    if logged_in?
      @user = current_user 
      erb :'/tweets/tweets'
    else 
      redirect '/users/login'
    end  
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      @user = current_user(session)
      erb :'/tweets/new'
    else
      redirect '/users/login'
    end
  end

  post '/tweets/new' do   
    if params[:content] == "" 
      redirect '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content])  
      @user = current_user
      @tweet.user_id = @user.id 
      @tweet.save
      redirect '/tweets/tweets'
    end
   end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params["id"])
      erb :'tweets/show'
    else
      redirect '/users/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params["id"])
      erb :'tweets/edit'
    else
      redirect '/users/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params["id"])
    @tweet.content = params["content"]
    @tweet.save
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params["id"])
    if is_logged_in?(session) && current_user(session).id == @tweet.user_id
      @tweet.destroy
      redirect '/tweets/tweets'
    elsif is_logged_in?(session)
      redirect '/tweets/tweets'
    else
      redirect '/users/login'
    end
  end


  #CREATE SESSIONS

  def current_user(session)
   @user = User.find_by_id(session['user_id'])
  end
 
  def is_logged_in?(session)
    !!session[:id]
  end


end
