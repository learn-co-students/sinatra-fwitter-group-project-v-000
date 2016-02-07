require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "billy"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    end
      erb :signup
  end

  post '/signup' do
    @user = User.find_or_create_by(username: params['username'], email: params['email'], password: params['password'])
    if @user.save
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params['username'], password: params['password'])
    session[:id] = @user.id
    redirect "/tweets"
  end

  get '/tweets' do
    @user = User.find(session[:id])
    @tweets = @user.tweets

    if @user
      erb :tweets
    else
      redirect "/login"
    end

  end


end