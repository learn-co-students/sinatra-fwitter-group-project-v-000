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

  get '/tweets/new' do
    if !is_logged_in?
      redirect '/login'
    else
      erb :'/tweets/create_tweet'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(:content => params[:content], :user_id => params[:user_id])
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username].empty?
      redirect to :'/signup'
    elsif params[:email].empty?
      redirect to :'/signup'
    elsif params[:password].empty?
      redirect to :'/signup'
    else @user = User.create(params)
    redirect to :'tweets/tweets'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    end
    erb :"users/login"
  end

  post '/login' do
    if @current_user = User.find_by(params[:username])
      session[:user_id] = @current_user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end

end
