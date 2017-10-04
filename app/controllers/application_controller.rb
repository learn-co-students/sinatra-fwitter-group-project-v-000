require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions
  set :session_secret, "my_application_secret"

  use Rack::Flash, :sweep => true

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    redirect to("/tweets") if User.is_logged_in?(session)
    erb :'users/create_user'    
  end

  post '/signup' do    
    flash[:err_no_username] = "Please choose a username." if params[:username].empty?    
    flash[:err_no_email] = "Please enter your email address." if params[:email].empty?    
    flash[:err_no_password] = "Please choose a password." if params[:password].empty?     
    
    query = params.map{|key, value| "#{key}=#{value}" if key != "password"}.join("&")

    if flash[:err_no_username] || flash[:err_no_email] || flash[:err_no_password]
      redirect to("/signup?#{query}")
    else  
      new_user = User.create(params)
      session[:id] = new_user.id      
      redirect to("/tweets")
    end    

  end

  get '/login' do
    redirect to("/tweets") if User.is_logged_in?(session)
    erb :'users/login'
  end

  post '/login' do
    query = params.map{|key, value| "#{key}=#{value}" if key != "password"}.join("&")

    login_user = User.find_by(username: params[:username])

    flash[:err_no_username] = "Please enter your username." if params[:username].empty?    
    flash[:err_no_password] = "Please enter your password." if params[:password].empty?
    flash[:err_username_not_found] = "#{params[:username]} is not a valid username. Please try again." if login_user.nil?

    redirect to("/login?#{query}") if flash[:err_no_username] || flash[:err_no_password] || flash[:err_username_not_found]
        
    if login_user && login_user.authenticate(params[:password])
      session[:id] = login_user.id
      redirect to("/tweets")
    else
      flash[:err_incorrect_password] = "Incorrect password. Please try again."
      redirect to("/login?#{query}")
    end
  end

  get '/logout' do
    session.clear
    redirect to("/login")
  end

end