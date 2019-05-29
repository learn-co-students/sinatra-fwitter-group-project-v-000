require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "changeme"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    # binding.pry
    if logged_in?
      redirect "/tweets/index"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    # binding.pry

    if params[:name].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @new_user = User.create(username: params[:name], email: params[:email], password: params[:password])
      redirect "/tweets/index"
    end
      # @new_user = User.new(username: params[:username], email: params[:email], password: params[:password])
      # if @new_user.save
      #   redirect "/tweets/index"
      # else
      #   redirect "/signup"
      # end
  end

  get '/login' do
    # binding.pry
    erb :'/users/login'
  end

  post '/login' do
    # binding.pry
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # binding.pry
      redirect "/tweets/index"
    else
      redirect "/login"
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
