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
    if session[:id] then redirect "/tweets" end
    erb :"/users/create_user"
  end

  get '/tweets' do
    if !session[:id] then redirect "/login" end
    @user=User.find(session[:id])
    erb :"/tweets/tweet"
  end

  get '/tweets/new' do
    if !session[:id] then redirect "/login" end
    @user=User.find(session[:id])
    erb :"/tweets/new"
  end

  get "/tweets/:id" do
    if !session[:id] then redirect "/login" end
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    if !session[:id] then redirect "/login" end
    @tweet = Tweet.find(params[:id].to_i)
    if session[:id] != @tweet.id then redirect "/tweets" end
    erb :"/tweets/edit_tweet"
  end

  post '/tweets/new' do
    if !session[:id] then redirect "/login" end
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
    erb :"/tweets/tweets"
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
end
