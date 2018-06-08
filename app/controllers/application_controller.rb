require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  register Sinatra::ActiveRecordExtension



  set :views, Proc.new { File.join(root, "../views/") }
  # register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    erb :'../index'
  end

  helpers do
    def is_logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

  # get '/users/signup' do
  #   if is_logged_in?
  #     redirect '/tweets'
  #   else
  #     erb :'users/signup'
  #   end
  # end
  #
  # get '/login' do
  #   if is_logged_in?
  #     redirect '/tweets'
  #   else
  #     erb :'/users/login'
  #   end
  # end
  #
  # post '/login' do
  #   @user = User.find_by(username: params[:username], password: params[:password])
  #   if @user && @user.authenticate(params[:password])
  #     binding.pry
  #     session[:id] = @user.id
  #     redirect '/tweets'
  #   else
  #     redirect '/errors/login'
  #   end
  # end

  # post '/signup' do
  #   if !params.values.all?{|param| !param.empty?}
  #     redirect '/errors/signup'
  #   end
  #
  #   if is_logged_in?
  #     redirect '/tweets'
  #   end
  #
  #   if !!@user = User.find_by(email: params[:email])
  #     redirect '/users/login'
  #   end
  #   binding.pry
  #   @user = User.new(username: params[:username], email: params[:email], password: params[:password])
  #   @user.save
  #   session[:id] = @user.id
  #   redirect '/tweets'
  # end
  # 
  # get '/logout' do
  #   session.clear
  #
  #   redirect to '/'
  # end
end
