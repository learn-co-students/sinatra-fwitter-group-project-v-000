require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'fwitter_session'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in? 
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    field_empty = 
      params[:username] == '' || 
      params[:email] == '' || 
      params[:password] == ''

    if field_empty 
      redirect '/signup'
    else
      user = User.create(
        username: params[:username], 
        email: params[:email], 
        password: params[:password]
      )

      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  # Users
  get '/users/:id' do
    if current_user.id == params[:id]
      erb :'users/show'
    else
      redirect '/login'
    end
  end

  # Tweets
  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all

      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ''
      redirect '/tweets/new'
    else
      tweet = Tweet.create(
        content: params[:content], user_id: current_user.id
      )

      redirect :"tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ''
      redirect :"tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])

      redirect :'/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
          
    redirect :'/tweets'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
