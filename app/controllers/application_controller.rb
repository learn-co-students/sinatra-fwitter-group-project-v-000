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
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def valid_user?
      is_logged_in? && (@user = User.find_by(email: params[:email]))
  end
end
