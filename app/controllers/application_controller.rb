require './config/environment'

class ApplicationController < Sinatra::Base
   configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, "password_security"
   end

   get '/' do
      erb :index
   end

   get '/signup' do
      if !logged_in?
         erb :'users/create_users'
      else
         redirect '/tweets'
      end
   end

   post '/signup' do
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      if !@user.username.empty? && !@user.email.empty? && @user.save
         session[:user_id] = @user.id
         redirect '/tweets'
      else
         redirect "/signup"
      end
   end

   get '/login' do
      # binding.pry
      if !logged_in?
         erb :"users/login"
      else
         redirect '/tweets'
      end
   end

   post '/login' do
      # binding.pry
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect "/tweets"
      else
         redirect '/login'
      end
   end

   get "/logout" do
      if logged_in?
         session.clear
         redirect "/login"
      else
         redirect "/"
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
