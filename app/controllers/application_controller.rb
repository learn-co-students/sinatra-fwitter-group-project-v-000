require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'billy'
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
    if session[:id] == nil
      erb :login
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params['username'], password: params['password'])
    session[:id] = @user.id
    redirect '/tweets'
  end

  get '/tweets' do
    if session[:id] != nil
      @user = User.find(session[:id])
      @tweets = @user.tweets
      erb :tweets
    else
      redirect '/login'
    end

  end

  get '/logout' do
    if session[:id] != nil
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end


end