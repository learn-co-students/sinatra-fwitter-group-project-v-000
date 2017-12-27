require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    redirect('/tweets') if logged_in?
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect('/tweets')
    else
      redirect('/login')
    end
  end

  get '/signup' do
    redirect('/tweets') if logged_in?
    erb :signup
  end

  post '/signup' do    
    user = User.new(params)
    if user.save && !user.username.empty? && !user.email.empty?
      session[:user_id] = user.id
      redirect('/tweets')
    else
      redirect('/signup')
    end
  end

  get '/logout' do
    session.clear
    redirect('/login')
  end

  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    # binding.pry
    erb :show
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

end