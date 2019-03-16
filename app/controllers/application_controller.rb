require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "secret"
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :"/users/create_user"
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    binding.pry
    @user = User.find_by(:username => params[:username])
    if @user == nil
      redirect to '/login'
    if @user.password == params[:password]
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end







  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
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
