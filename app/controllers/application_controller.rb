
class ApplicationController < Sinatra::Base 
  # register Sinatra::ActiveRecordExtension
  configure do
    enable :sessions
    set :session_secret, "fwitter_secret"
  end
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end

  end

  post '/signup' do

    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    
    if user.save
      session[:user_id] = user.id
      go_to = '/tweets'
    else
      go_to = '/signup'
    end

    redirect to go_to
  end

  get '/login' do 
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      go_to = '/tweets'
    else
      go_to = '/login'
    end

    redirect to go_to
  end

  get '/logout' do 
    if logged_in?
      session.clear
    end
    redirect to '/login'
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