require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    redirect to('/tweets') if is_logged_in?
    erb :signup
  end

  post '/signup' do
    a = params[:username]
    b = params[:email]
    c = params[:password]

    [a, b, c].each do |param|
      redirect to('/signup') if param.empty?
    end

    @user = User.create( username: a, email: b, password: c)
    session[:user_id] = @user.id
    redirect to('/tweets')
  end

  get '/login' do
    redirect to('/tweets') if is_logged_in?
    erb :login
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to('/tweets')
    else
      redirect to('/login')
    end
  end

  helpers do
    def is_logged_in?
      !session[:user_id].nil?
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
