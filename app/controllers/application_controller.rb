require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
<<<<<<< HEAD
    set :session_secret, "changeme"
=======
    set :session_secrets, "hello"
>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
  end



  get '/' do
    erb :index
  end

  get '/signup' do
<<<<<<< HEAD
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/create_user'
=======
    # binding.pry
    if logged_in?
      redirect "/tweets"
    else
    erb :'/users/create_user'
>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
    end
  end

  post '/signup' do
<<<<<<< HEAD
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @new_user = User.create(username: params[:username], email: params[:email], password: params[:password])
=======
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect "/signup"
    else
      @new_user = User.create(username: params[:username], email: params[:email], password: params[:password])
      # @new_user.save
>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
      session[:user_id] = @new_user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
<<<<<<< HEAD
      erb :'/users/login'
=======
      erb :'users/login'
>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

<<<<<<< HEAD
  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    end
    redirect "/tweets"
  end




  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

=======
  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/tweets"
    end
  end

  # post '/logout' do
  #   # binding.pry
  #   session[:user_id].delete
  #   # session[:user_id].delete
  #   # session[:user_id].delete
  # end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end


>>>>>>> fb1e67ae4cc0c9c4125ba043b384e948ef5f0118
end
