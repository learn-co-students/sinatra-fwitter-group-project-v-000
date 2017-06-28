require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "fwitter"
  end

  get '/' do

    erb :index
  end

  get '/signup' do
    redirect("/tweets") if logged_in?(session)

    erb :signup
  end
  
  post '/signup' do
    @user = User.new(params)

    if @user.save
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
    
  end
  
  get '/login' do
    redirect("/tweets") if logged_in?(session)
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
    else
      redirect "/login"
    end
    redirect "/tweets"
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end
  
  get '/tweets' do
    @tweets = Tweet.all
    @user = current_user(session)
    if logged_in?(session)
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    redirect("/login") if !logged_in?(session)
    erb :'tweets/new'
  end

  post '/tweets/new' do
    redirect back if params[:content].empty?
    @tweet = Tweet.create(params)
    @tweet.user = current_user(session)
    @tweet.save
    redirect "/tweets"
  end

  get '/tweets/:id' do
    redirect("/login") if !logged_in?(session)
    @tweet = Tweet.find(params[:id])
    @current_user = current_user(session)
    erb :'tweets/show'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete if current_user(session).id == @tweet.user.id
    redirect "/tweets"
  end

  get '/tweets/:id/edit' do
    redirect("/login") if !logged_in?(session)
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end

  patch '/tweets/:id/edit' do
    redirect back if params[:content].empty?
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/index'
  end


  helpers do
    def logged_in?(session)
      !!session[:id]
    end
    
    def current_user(session)
        User.find(session[:id]) if session[:id]
    end
    
  end

  


end