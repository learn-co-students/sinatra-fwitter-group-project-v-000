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

  get '/signup' do
    if logged_in? then redirect "/tweets" end
    erb :"/users/create_user"
  end

  get '/tweets' do
    if !logged_in? then redirect "/login" end
    @user=current_user
    erb :"/tweets/tweets"
  end

  get '/tweets/new' do
    if !logged_in? then redirect "/login" end
    @user=current_user
    erb :"/tweets/new"
  end

  get "/tweets/:id" do
    if !logged_in? then redirect "/login" end
   @session=session
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    if !logged_in? then redirect "/login" end
    @tweet = Tweet.find(params[:id].to_i)
    @user=@tweet.user
    if session[:id]!= @user.id then redirect "/tweets" end
    erb :"/tweets/edit_tweet"
  end

  post '/tweets/new' do
    if !logged_in? then redirect "/login" end
    if params[:content]=="" then redirect "/tweets/new" end
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])
    redirect "/tweets"
  end

  post '/tweets/:id' do
    if params[:content]=="" then redirect "/tweets/#{params[:id]}/edit" end
    @tweet=Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save
    redirect "/tweets"
  end

  post '/tweets/:id/delete' do
    tweet=Tweet.find(params[:id])
    if tweet.user.id==session[:id] then tweet.delete end
    redirect "/tweets"     
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/users/:slug' do
    @user=User.find_by_slug(params[:slug])
    erb :"/tweets/user_profile"
  end

  post '/signup' do
    if params[:email]=="" then redirect "/signup" end
    if params[:username]=="" then redirect "/signup" end
    if params[:password]=="" then redirect "/signup" end
    @user=User.create(params)
    session[:id] = @user.id
    redirect "/tweets"
  end

  get '/login' do
    if session[:id] then redirect "/tweets" end
    erb :"/users/login"
  end

  post '/login' do
    user= User.find_by(username: params[:username])
    # redirect "/tweets"
    if user && user.authenticate(params[:password])
      session[:id]=user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

   helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
   end
   
end
